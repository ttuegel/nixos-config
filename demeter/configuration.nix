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
    ../programs/fish.nix
  ];

  networking.hostName = "demeter";

  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [
      3338  # Jenkins agent
    ];
  };

  nix.maxJobs = 16;

  powerManagement.cpuFreqGovernor = "ondemand";

  services.printing.enable = true;

  system.stateVersion = "18.03";

  time.timeZone = "America/Chicago";
}
