{ config, ... }:

let
  pkgs = import ./nixpkgs { inherit (config.nixpkgs) config; };
in

{
  environment.systemPackages = [
    pkgs.gitAndTools.git-annex
  ];
}
