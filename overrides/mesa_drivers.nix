super: self:

{
  # Build mesa_drivers with llvm_36.
  # The r600 driver doesn't work with llvm_37.
  /*
  mesa_drivers =
    let mo = self.mesa_noglu.override {
          llvmPackages = self.llvmPackages_36;
        };
    in self.mesaDarwinOr mo.drivers;

  llvm_37 = with self; lib.overrideDerivation
    (super.llvm_37.override {
      compiler-rt_src = fetchurl {
        url = http://llvm.org/releases/3.7.1/compiler-rt-3.7.1.src.tar.xz;
        sha256 = "10c1mz2q4bdq9bqfgr3dirc6hz1h3sq8573srd5q5lr7m7j6jiwx";
      };
    })
    (args: {
      name = "llvm-3.7.1";
      src = fetchurl {
        url = http://llvm.org/releases/3.7.1/llvm-3.7.1.src.tar.xz;
        sha256 = "1masakdp9g2dan1yrazg7md5am2vacbkb3nahb3dchpc1knr8xxy";
      };
      patches = [];
    });
  */
}
