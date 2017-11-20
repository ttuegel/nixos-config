{
  stdenv, rustPlatform,
  fetchgit,
  cmake, pkgconfig, python3,
  expat, freetype, fontconfig, gperf, xclip,
  libX11, libXcursor, libXfixes, libXft, libXi, libXrandr, libXrender,
  libXxf86vm, libxcb
}:

with rustPlatform;

let
  rpathLibs = [
    expat
    freetype
    fontconfig
    libX11
    libXcursor
    libXfixes
    libXft
    libXi
    libXrandr
    libXrender
    libXxf86vm
    libxcb
  ];
in buildRustPackage rec {
  name = "alacritty-unstable-${version}";
  version = "20171119";

  src = fetchgit {
    url = https://github.com/ttuegel/alacritty.git;
    rev = "762d9b90889158147f2e793186d66b12408549d2";
    sha256 = "1ljvsxha174gj5w86aibk8pghznbn92ky7q3rck9y7xc0gh9a99w";
    fetchSubmodules = true;
  };
  cargoSha256 = "0z0ysvi31jqckyw9j60z7rkrmmzqfz61w3ypaxj3mbm4aalhy7fl";

  nativeBuildInputs = [
    cmake
    pkgconfig
    python3  # xcb crate uses a code generation script
  ];

  buildInputs = rpathLibs;

  postPatch = ''
    substituteInPlace copypasta/src/x11.rs \
      --replace Command::new\(\"xclip\"\) Command::new\(\"${xclip}/bin/xclip\"\)
  '';

  # BUG: rustc periodically runs out of jobserver tokens
  # Hammer `cargo build' until it succeeds.
  buildPhase = ''
    runHook preBuild
    while ! cargo build --release --frozen
    do
        echo "restarting \`cargo build'..."
    done
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -D target/release/alacritty $out/bin/alacritty
    patchelf --set-rpath "${stdenv.lib.makeLibraryPath rpathLibs}" $out/bin/alacritty

    install -D Alacritty.desktop $out/share/applications/alacritty.desktop

    runHook postInstall
  '';

  checkPhase = ''
    runHook preCheck
    # noop
    runHook postCheck
  '';

  dontPatchELF = true;

  meta = with stdenv.lib; {
    description = "GPU-accelerated terminal emulator";
    homepage = https://github.com/jwilm/alacritty;
    license = with licenses; [ asl20 ];
    maintainers = with maintainers; [ mic92 ];
    platforms = platforms.linux;
  };
}
