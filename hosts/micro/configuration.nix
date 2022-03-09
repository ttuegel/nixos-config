{ config, pkgs, ... }:

{
  imports = [
    ../../config
    ../../features/desktop.nix
    ../../features/dvorak-swapcaps
    ../../programs/nix.nix
    ../../users.nix
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

  services.xserver = {
    enable = true;
    desktopManager.plasma5.enable = true;
    displayManager.sddm.enable = true;
  };

  users.users = {
    root.initialPassword = "root";
    alice = { isNormalUser = true; initialPassword = "alice"; };
    bob = { isNormalUser = true; initialPassword = "bob"; };
  };

  virtualisation.memorySize = 1024;
}
