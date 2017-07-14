{ config, pkgs, ... }:

let

  # Rebuilding Mathematica can change important hashes, voiding the
  # registration, so it must be pinned to a particular NixOS version.

  channel = pkgs.fetchFromGitHub {
    owner = "ttuegel";
    repo = "nixpkgs";
    rev = "9b4ac151a496fc97e7faf0e81cf35b663eb26a07";
    sha256 = "1bs35zxzrb7yqxnsc7v2nw4ss6xbwdmfgip2sikskrgsdpcnic8k";
  };

  inherit (import channel { inherit (config.nixpkgs) config; }) mathematica;

in

{
  environment.systemPackages = [
    mathematica
  ];
}
