{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    direnv direnv-nix-lorelei direnv-nix
  ];

  environment.pathsToLink = [ "/share/nix-direnv" ];

}
