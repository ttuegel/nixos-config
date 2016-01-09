super: self:

{
  # Build mesa_drivers with llvm_36.
  # The r600 driver doesn't work with llvm_37.
  mesa_drivers =
    let mo = self.mesa_noglu.override {
          llvmPackages = self.llvmPackages_36;
        };
    in self.mesaDarwinOr mo.drivers;
}
