{ config, pkgs, ... }:

{
  imports = [
    ../config
    ../features/desktop.nix
    ../features/dvorak-swapcaps
    ../programs/nix.nix
  ];

  networking.hostName = "nixos-micro";

  time.timeZone = "America/Chicago";

  environment.systemPackages = with pkgs; [
    git
    htop
    manpages
    ripgrep
    tmux
  ];

  programs.fish.enable = true;

  virtualisation.memorySize = 1024;
}
