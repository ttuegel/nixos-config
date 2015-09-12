{ stdenv, requireFile, libtool, openblas, gfortran }:

stdenv.mkDerivation {
  name = "feast-2.1";

  src = ../../annex/.git/annex/objects/xF/kG/SHA256E-s5697956--65e671d986689def171a9cbc82ff0601c21c5e738ec6436fc3fcea95340643eb.1.tgz/SHA256E-s5697956--65e671d986689def171a9cbc82ff0601c21c5e738ec6436fc3fcea95340643eb.1.tgz;
  patches = [
    ./0001-use-gfortran.patch
    ./0002-don-t-build-sparse.patch
    ./0003-use-fPIC.patch
  ];

  buildInputs = [ openblas gfortran ];
  nativeBuildInputs = [ libtool ];

  preConfigure = ''
    export FEASTROOT=$(pwd)
    cd 2.1/src
  '';

  makeFlags = [
    "ARCH=nix"
    "LIB=feast"
    "all"
  ];

  postBuild = ''
    for i in ../lib/nix/lib*.a; do
      ar -x $i
    done

    libtool --mode=link gcc -shared -o libfeast.la \
      f90_functions_wrapper.o feast.o \
      -lgfortran -lopenblas \
      -rpath $out/lib
    libtool --mode=link gcc -shared -o libfeast_dense.la \
      feast_dense.o \
      -lfeast \
      -rpath $out/lib
    libtool --mode=link gcc -shared -o libfeast_banded.la \
      feast_banded.o \
      -lfeast \
      -rpath $out/lib
  '';

  installPhase = ''
    mkdir -p $out/lib
    for lib in libfeast*.la; do
      libtool --mode=install install -c $lib $out/lib/$lib
    done

    mkdir -p $out/include
    cd ../include
    for header in *.h; do
      cp $header $out/include
    done
    cd $FEASTROOT
  '';

  meta = {
    homepage = http://www.ecs.umass.edu/~polizzi/feast;
    license = with stdenv.lib.licenses; [ bsd3 ];
    maintainers = with stdenv.lib.maintainers; [ ttuegel ];
  };
}
