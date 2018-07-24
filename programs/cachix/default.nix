{ pkgs, ... }:

let
  lock = builtins.fromJSON (builtins.readFile ./lock.json);
  cachix = import (pkgs.fetchFromGitHub {
    owner = "cachix";
    repo = "cachix";
    inherit (lock) rev sha256;
  }) {};
in
{
  environment.systemPackages = [ cachix ];
}
