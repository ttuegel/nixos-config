{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    direnv nix-direnv
  ];

  environment.pathsToLink = [ "/share/nix-direnv" ];
}
