{ stdenv, lib, fetchFromGitHub, nodejs-8_x, otfcc, ttfautohint
, design ? [], upright ? [], italic ? [], oblique ? [], set ? null
}:

assert (design != []) -> set != null;
assert (upright != []) -> set != null;
assert (italic != []) -> set != null;
assert (oblique != []) -> set != null;

let pname = if set != null then "iosevka-${set}" else "iosevka"; in
let version = "1.13.2"; in
let unwords = lib.concatStringsSep " "; in

let
  param = name: options:
    if options != [] then "${name}='${unwords options}'" else null;
  config = unwords (lib.filter (x: x != null) [
    (param "design" design)
    (param "upright" upright)
    (param "italic" italic)
    (param "oblique" oblique)
  ]);
  custom = design != [] || upright != [] || italic != [] || oblique != [];
in

stdenv.mkDerivation {
  inherit pname version;
  name = "${pname}-${version}";
  src = fetchFromGitHub {
    owner = "ttuegel";
    repo = "Iosevka";
    rev = "6d644356f6f5ea106116ecc97d4e100f1f02aeef";
    sha256 = "0219x7ssaxmghp5lwv8l5kp6ynnzw6d1y3glqka83yx5737r8377";
  };
  nativeBuildInputs = [ nodejs-8_x otfcc ttfautohint ];
  inherit custom;
  configurePhase = ''
    runHook preConfigure

    if [ -n "$custom" ]; then
        make custom-config set=${set} ${config}
    fi

    runHook postConfigure
  '';
  buildPhase = ''
    runHook preBuild

    if [ -n "$custom" ]; then
        make custom set=${set}
    else
        make
    fi

    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall

    fontdir="$out/share/fonts/$pname"
    install -d "$fontdir"
    install "dist/$pname/ttf"/* "$fontdir"

    runHook postInstall
  '';
  meta = with lib; {
    homepage = "https://github.com/be5invis/Iosevka";
    license = with licenses; [ bsd3 ofl ];
    platforms = platforms.all;
  };
}
