{ config, pkgs, ... }:

{
  nixpkgs.config = {
    packageOverrides = super: let self = super.pkgs; in {
      # Build mesa_drivers with llvm_36.
      # The r600 driver doesn't work with llvm_37.
      mesa_drivers = self.mesaDarwinOr (
        let mo = self.mesa_noglu.override {
              llvmPackages = self.llvmPackages_36;
            };
        in mo.drivers
      );
    };
  };
}
