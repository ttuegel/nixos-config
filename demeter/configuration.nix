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

  boot.kernelPackages = pkgs.linuxPackages_5_4;

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

  services.nix-serve.secretKeyFile = "/var/lib/nix-serve/demeter.ttuegel-1.key";

  system.stateVersion = "18.03";

  time.timeZone = "America/Chicago";

  virtualisation.lxd.enable = true;
}
