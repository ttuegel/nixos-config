{ config, pkgs, ... }:

{
  nixpkgs.config = import ./config.nix pkgs;
  nixpkgs.overlays = import ./overlays.nix;
}
