{ config, ... }:

let
  pkgs = import ./nixpkgs { inherit (config.nixpkgs) config; };
  mathematica = pkgs.callPackage ./mathematica.nix {
    patchelf = pkgs.callPackage ./patchelf.nix {};
  };
in

{
  environment.systemPackages = [ mathematica ];
}
