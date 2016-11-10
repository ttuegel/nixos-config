{ stdenv, fetchFromGitHub, cmake
, mesa_noglu, libSM, SDL, SDL_image, SDL_ttf, glew, openalSoft
, ncurses, glib, gtk2, libsndfile, zlib
}:

stdenv.mkDerivation {
  name = "dwarf_fortress_unfuck-2016-05-10";

  src = fetchFromGitHub {
    owner = "svenstaro";
    repo = "dwarf_fortress_unfuck";
    rev = "e544f5f0b7788cc870442f2c469ef3af92fab5cc";
    sha256 = "10cq5jpglhc0qg8ls2xw9xb42vs3vnl8j8kxfqc9v3q4w1bvacks";
  };

  cmakeFlags = [
    "-DGTK2_GLIBCONFIG_INCLUDE_DIR=${glib.out}/lib/glib-2.0/include"
    "-DGTK2_GDKCONFIG_INCLUDE_DIR=${gtk2.out}/lib/gtk-2.0/include"
  ];

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    libSM SDL SDL_image SDL_ttf glew openalSoft
    ncurses gtk2 libsndfile zlib mesa_noglu
  ];

  installPhase = ''
    install -D -m755 ../build/libgraphics.so $out/lib/libgraphics.so
  '';

  # Ensure that GCC outputs the correct destructor symbols for dfhack
  patches = [ ./renderer_destructor.patch ];

  enableParallelBuilding = true;

  passthru.dfVersion = "0.43.03";

  meta = with stdenv.lib; {
    description = "Unfucked multimedia layer for Dwarf Fortress";
    homepage = https://github.com/svenstaro/dwarf_fortress_unfuck;
    license = licenses.free;
    platforms = platforms.linux;
    maintainers = with maintainers; [ abbradar ];
  };
}
