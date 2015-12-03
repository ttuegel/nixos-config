{ config, pkgs, ... }:

{
  nixpkgs.config = import ./config.nix pkgs;
}
