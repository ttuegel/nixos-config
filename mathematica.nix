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
, nettools
, opencv
, openssl
, p7zip
, unixODBC
, utillinux
, xlibs
, zlib
}:

stdenv.mkDerivation rec {

  name = "mathematica-10.2.0";

  nativeBuildInputs = [ nettools patchelf p7zip ];

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

  ldpath = stdenv.lib.makeLibraryPath buildInputs;

  phases = "unpackPhase installPhase fixupPhase";

  src = requireFile rec {
    name = "Mathematica_10.2.0_LINUX.iso";
    message = "Mathematica_10.2.0_LINUX.iso must be in the store.";
    sha256 = "1zkx9fi4maqnm93kz9hwabyyvybmqir1ycq4n98dzb44mk2xvwnp";
  };

  unpackPhase = ''
    7z x "$src"
  '';
  sourceRoot = "Unix/Installer";

  installPhase = ''
    # don't restrict PATH, that has already been done
    sed -i -e '/^PATH=/ s/^/#/' MathInstaller
    sed -i -e '/^usrBase=/ s/=.*/=$out\/share/' MathInstaller
    chmod +x MathInstaller

    ./MathInstaller \
        -auto -createdir=y \
        -execdir=$out/bin \
        -targetdir=$out/libexec/Mathematica
  '';

  preFixup = ''
    interpreter=$(cat $NIX_CC/nix-support/dynamic-linker)
    getType='s/ *Type: *\([A-Z]*\) (.*/\1/'
    echo "interpreter is $interpreter"
    find $out/libexec \( -type f -a \( -perm +0100 -o -name "*.so*" \) \) \
        | while read f; do
            echo "patching $f..."
            dynamic=$(readelf -S "$f" 2>/dev/null | grep "DYNAMIC" || true)

            if [[ -n "$dynamic" ]]; then
                type=$(readelf -h "$f" 2>/dev/null | grep 'Type:' | sed -e "$getType")

                if [[ "$type" == "EXEC" ]]; then

                    echo "patching interpreter path in $type $f"
                    patchelf --set-interpreter "$interpreter" "$f"

                    echo "patching RPATH in $type $f"
                    oldRPATH=$(patchelf --print-rpath "$f")
                    patchelf --set-rpath "''${oldRPATH:+$oldRPATH:}$ldpath" "$f"

                    echo "shrinking RPATH in $type $f"
                    patchelf --shrink-rpath "$f"

                elif [[ "$type" == "DYN" ]]; then

                    echo "patching RPATH in $type $f"
                    oldRPATH=$(patchelf --print-rpath "$f")
                    patchelf --set-rpath "''${oldRPATH:+$oldRPATH:}$ldpath" "$f"

                    echo "shrinking RPATH in $type $f"
                    patchelf --shrink-rpath "$f"

                else

                    echo "unknown ELF type \"$type\"; not patching $f"

                fi

            else

                echo "not a dynamic ELF object: $f"

            fi

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
