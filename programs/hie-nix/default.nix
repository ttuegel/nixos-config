{ config, pkgs, ... }:

let inherit (pkgs) fetchgit; in

let
  hie-nix = fetchgit {
    inherit (builtins.fromJSON (builtins.readFile ./hie-nix.json))
      url rev sha256 fetchSubmodules;
  };
in

{
  environment.systemPackages =
    with (import hie-nix {});
    [ hie82 hie84 ];
}
