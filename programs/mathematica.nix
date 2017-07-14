{ config, pkgs, ... }:

let

  # Rebuilding Mathematica can change important hashes, voiding the
  # registration, so it must be pinned to a particular NixOS version.

  channel = pkgs.fetchFromGitHub {
    owner = "ttuegel";
    repo = "nixpkgs";
    rev = "82d63a973f43c9182651d4b8424d8debc37892db";
    sha256 = "046bfmaaxhvd5qfg1f92p5n206aq3vjx1bzrw9r3p80j2h70kpi5";
  };

  inherit (import channel { inherit (config.nixpkgs) config; }) mathematica;

in

{
  environment.systemPackages = [
    mathematica
  ];
}
