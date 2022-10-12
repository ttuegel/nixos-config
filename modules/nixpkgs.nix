{ config, pkgs, ... }:

{
  nixpkgs.config = import ../nixpkgs/config.nix pkgs;
}
