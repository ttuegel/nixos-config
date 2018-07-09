{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../config
    ../features/desktop.nix
    ../features/dvorak-swapcaps
    ../features/fstrim.nix
    ../features/nix-serve.nix
    ../programs
    ../programs/dropbox.nix
    ../programs/emacs.nix
  ];

  networking.hostName = "demeter";

  networking.firewall = {
    enable = true;
    allowPing = true;
  };

  nix.maxJobs = 16;

  powerManagement.cpuFreqGovernor = "ondemand";

  programs.fish.enable = true;

  time.timeZone = "America/Chicago";

  system.stateVersion = "18.03";
}
