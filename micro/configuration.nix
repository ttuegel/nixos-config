{ config, pkgs, ... }:

{
  imports = [
    ../config
    ../features/desktop.nix
    ../features/dvorak-swapcaps
    ../programs/nix.nix
    ../programs/zsh.nix
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

  virtualisation.memorySize = 1024;
}
