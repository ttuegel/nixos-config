{ stdenv, fetchgit, fetchurl, cmake, writeScriptBin
, perl, XMLLibXML, XMLLibXSLT
, zlib
, jsoncpp, protobuf, mesa_noglu
}:

let
  dfVersion = "0.43.03";
  version = "${dfVersion}-r1";

  rev = "refs/tags/${version}";
  # revision of library/xml submodule
  xmlRev = "98cc1e01886aaea161d651cf97229ad08e9782b0";

  fakegit = writeScriptBin "git" ''
    #! ${stdenv.shell}
    if [ "$*" = "describe --tags --long" ]; then
      echo "${version}-unknown"
    elif [ "$*" = "rev-parse HEAD" ]; then
      if [ "$(dirname "$(pwd)")" = "xml" ]; then
        echo "${xmlRev}"
      else
        echo "${rev}"
      fi
    elif [ "$*" = "rev-parse HEAD:library/xml" ]; then
      echo "${xmlRev}"
    else
      exit 1
    fi
  '';

  twbt_version = "5.70";
  twbt = fetchurl {
    url = "https://github.com/mifki/df-twbt/archive/v${twbt_version}.tar.gz";
    sha256 = "1b6rl3kn36n1lrq1dwbgb05mal3n05ip15whc0bg4msps1xdnnv8";
  };

in stdenv.mkDerivation rec {
  name = "dfhack-${version}";

  # Beware of submodules
  src = fetchgit {
    url = "https://github.com/DFHack/dfhack";
    inherit rev;
    sha256 = "0m5kqpaz0ypji4c32w0hhbsicvgvnjh56pqvq7af6pqqnyg1nzcx";
  };

  preConfigure = ''
    tar xaf ${twbt}
    mv df-twbt-${twbt_version} plugins/twbt
    echo "add_subdirectory(twbt)" >> plugins/CMakeLists.custom.txt
    mv plugins/twbt/plugins/*.cpp ./
    mv plugins/twbt/*.h library/include/
    sed -i plugins/twbt/CMakeLists.txt \
        -e 's/^SET( TWBT_VER.*$/SET ( TWBT_VER "${twbt_version}" )/'
  '';

  patches = [ ./use-system-libraries.patch ];

  nativeBuildInputs = [ cmake perl XMLLibXML XMLLibXSLT fakegit ];
  # we can't use native Lua; upstream uses private headers
  buildInputs = [ zlib jsoncpp protobuf mesa_noglu ];

  postInstall = ''
    mkdir -p $out/hack/lua
    cp $NIX_BUILD_TOP/$sourceRoot/plugins/twbt/dist/realcolors.lua $out/hack/lua/
  '';

  enableParallelBuilding = true;

  passthru = { inherit version dfVersion; };

  meta = with stdenv.lib; {
    description = "Memory hacking library for Dwarf Fortress and a set of tools that use it";
    homepage = "https://github.com/DFHack/dfhack/";
    license = licenses.zlib;
    platforms = [ "i686-linux" ];
    maintainers = with maintainers; [ robbinch a1russell abbradar ];
  };
}
