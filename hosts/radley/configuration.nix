{ config, pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in

{
  imports =
    [
      ./hardware.nix
      ../../modules/agenix.nix
      ../../modules/config.nix
      ../../modules/desktop.nix
      ../../modules/direnv.nix
      ../../modules/dvorak-swapcaps
      ../../modules/fish.nix
      ../../modules/hplip.nix
      ../../modules/programs.nix
      ../../modules/users.nix
      ../../modules/zerotier.nix
    ];

  boot.supportedFilesystems = [ "zfs" ];
  boot.kernelParams = [ "zfs.zfs_arc_max=1073741824" ];

  boot.loader.systemd-boot.enable = true;

  boot.tmp.useTmpfs = false;

  networking.hostName = "radley";
  networking.hostId = "01db539b";

  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowPing = true;
  };

  nix.settings = {
    max-jobs = 4;
    cores = 2;
  };

  time.timeZone = "America/Chicago";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:2:0:0";
  };
  environment.systemPackages = [ nvidia-offload ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
