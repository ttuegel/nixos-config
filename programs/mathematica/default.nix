{ config, ... }:

let

  # Rebuilding Mathematica can change important hashes, voiding the
  # registration, so it must be pinned to a particular NixOS version.
  pkgs = import ./nixpkgs { inherit (config.nixpkgs) config; };
  inherit (pkgs) mathematica;

in

{
  environment.systemPackages = [ mathematica ];
}
