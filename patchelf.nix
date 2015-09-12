{ stdenv, fetchurl, ttuegel, autoconf, automake }:

stdenv.mkDerivation rec {
  name = "patchelf-0.9-pre";

  src = builtins.filterSource ttuegel.omitGit ./patchelf;

  nativeBuildInputs = [ autoconf automake ];

  setupHook = [ <nixpkgs/pkgs/development/tools/misc/patchelf/setup-hook.sh> ];

  preConfigure = ''./bootstrap.sh'';

  meta = {
    homepage = http://nixos.org/patchelf.html;
    license = "GPL";
    description = "A small utility to modify the dynamic linker and RPATH of ELF executables";
    maintainers = [ stdenv.lib.maintainers.eelco ];
    platforms = stdenv.lib.platforms.all;
  };
}
