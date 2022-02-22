{ config, pkgs, ... }:

let
  sources = import ../nix/sources.nix;
  inherit (import sources."direnv-nix-lorelei") direnv-nix-lorelei;
in

{
  environment.systemPackages = with pkgs; [
    direnv direnv-nix-lorelei nix-direnv
  ];

  environment.pathsToLink = [ "/share/nix-direnv" ];

}
