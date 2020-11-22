{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../config
    ../../features/desktop.nix
    ../../features/dvorak-swapcaps
    ../../features/fstrim.nix
    ../../features/hplip.nix
    ../../features/nix-serve.nix
    ../../features/zerotier.nix
    ../../programs
    ../../programs/dropbox.nix
    ../../programs/emacs.nix
    ../../programs/fish.nix
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

  services.nix-serve.secretKeyFile = "/var/lib/nix-serve/demeter-2.secret.key";

  system.stateVersion = "18.09";

  time.timeZone = "America/Chicago";

  virtualisation.lxd.enable = true;
}
