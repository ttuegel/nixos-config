{ stdenv
, coreutils
, patchelf
, requireFile

, alsaLib
, atk
, cairo
, ffmpeg_0_10
, fontconfig
, freetype
, gcc
, gdk_pixbuf
, glib
, gtk
, libxml2
, libxslt
, ncurses
, opencv
, openssl
, p7zip
, unixODBC
, utillinux
, xlibs
, zlib
}:

let
  platform =
    if stdenv.system == "i686-linux" || stdenv.system == "x86_64-linux" then
      "Linux"
    else
      throw "Mathematica requires i686-linux or x86_64-linux";
in
stdenv.mkDerivation rec {

  name = "mathematica-10.0.0";

  nativeBuildInputs = [ patchelf p7zip ];

  buildInputs = [
    atk
    cairo
    coreutils
    alsaLib
    ffmpeg_0_10
    fontconfig
    freetype
    gdk_pixbuf
    gcc.cc
    gcc.libc
    glib
    gtk
    libxml2
    libxslt
    ncurses
    opencv
    openssl
    unixODBC
    utillinux
    zlib
  ] ++ (with xlibs; [
    libICE
    libSM
    libX11
    libXcursor
    libXext
    libXfixes
    libXft
    libXtst
    libXi
    libXmu
    libXrandr
    libXrender
    libXxf86vm
    libxcb
  ]);

  ldpath =
    stdenv.lib.makeLibraryPath buildInputs
    # add lib64/ to library path on 64-bit systems
    + stdenv.lib.optionalString
      (stdenv.system == "x86_64-linux")
      (":" + stdenv.lib.makeSearchPath "lib64" buildInputs);

  phases = "unpackPhase installPhase fixupPhase";

  src = requireFile rec {
    name = "Mathematica_10.0.0_LINUX.sh";
    message = "Mathematica_10.0.0_LINUX.sh must be in the store.";
    sha256 = "0nb544zdkwxqv2qyh0rxanap1qk29ma0r8fmmli4gjzsi1sypw4j";
  };

  unpackPhase = ''
    echo "=== Extracting makeself archive ==="
    # find offset from file
    # this is how the file itself does it
    offset=`head -n 387 $src | wc -c | tr -d " "`
    dd if="$src" ibs=$offset skip=1 | tar -xf -
    cd Unix
  '';

  installPhase = ''
    cd Installer
    # don't restrict PATH, that has already been done
    sed -i -e 's/^PATH=/# PATH=/' MathInstaller
    chmod +x MathInstaller

    echo "=== Running MathInstaller ==="
    ./MathInstaller -auto -createdir=y -execdir=$out/bin -targetdir=$out/libexec/Mathematica -platforms=${platform} -silent
  '';

  preFixup = ''
    echo "=== PatchElfing away ==="
    interpreter=$(cat $NIX_CC/nix-support/dynamic-linker)
    find $out/libexec/Mathematica/SystemFiles -type f -perm +100 | while read f; do
      type=$(readelf -h "$f" 2>/dev/null | grep 'Type:' | sed -e 's/ *Type: *\([A-Z]*\) (.*/\1/')

      if [[ "$type" == "EXEC" ]]; then
        echo "patching interpreter path in $type $f"
        patchelf --set-interpreter "$interpreter" "$f"
      fi

      if [[ "$type" == "EXEC" || "$type" == "DYN" ]]; then
        echo "patching RPATH in $type $f"
        oldRPATH=$(patchelf --print-rpath "$f")
        patchelf --set-rpath "$oldRPATH:${ldpath}" "$f" \
          && patchelf --shrink-rpath "$f" \
          || echo "unable to patch $f" 1>&2
      else
        echo "unknown ELF type; not patching $f"
      fi

      echo "done patching $f"

    done
  '';

  # all binaries are already stripped
  dontStrip = true;

  # we did this in prefixup already
  dontPatchELF = true;

  meta = {
    description = "Wolfram Mathematica computational software system";
    homepage = "http://www.wolfram.com/mathematica/";
    license = "unfree";
  };
}
