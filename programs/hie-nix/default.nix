{ config, pkgs, ... }:

let inherit (pkgs) fetchgit; in

let
  lock =
    builtins.fromJSON (builtins.readFile ./hie-nix.json);
  bootstrap = fetchgit {
    inherit (lock) url rev sha256 fetchSubmodules;
  };
  hie-nix = import bootstrap {};
in

{
  environment.systemPackages = [ hie-nix.hies ];
}
