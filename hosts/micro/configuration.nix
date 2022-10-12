{ config, pkgs, ... }:

{
  imports = [
    ../../modules/config.nix
    ../../modules/desktop.nix
    ../../modules/dvorak-swapcaps
    ../../modules/nix.nix
    ../../modules/users.nix
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
