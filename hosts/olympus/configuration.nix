{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/zerotier.nix
    ./hardware-configuration.nix
    ./nginx.nix
    ./wireguard.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/vda"; # or "nodev" for efi only

  networking.hostName = "olympus"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.ens3.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git htop nano
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";

  programs.fish.enable = true;

  security.pam.enableSSHAgentAuth = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.ttuegel = {
    uid = 1000;
    isNormalUser = true;
    description = "Thomas Tuegel";
    home = "/home/ttuegel";
    createHome = true;
    group = "users";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = "/run/current-system/sw/bin/fish";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfJ6ioMR5fAtMtjLDxE/Pwq+5M5qmox1/4OyLSNFjq3b5WUftkpQ7aT0x8Rxfdt5H/XmJK4OMAQv2jT7GmsYaLQUL9MQjN+/NLxEOhPu6geURMPaq/VkFWAHlGkpeAB/T4Fl9OanETa1hkcowZwjA4rxNxonxKyNveH16tNhAurHv6Fz57KP28ne6GX9nN3lP0EgaGP+y9ZRqWW5OYZ5+A5AjKxhQ1qu2ivwfLU+9KXaa7HY6YIPrJKHcmxhAU1H7FEIs5o/EnHKVllLbNQn3B3fJp6tCVzmUHEmmS2/cuoDd16+vk98uB0b3kuGccykwDOJTZpCNV6v9dY8ptqHx1 (none)"
    ];
  };

  system.stateVersion = "20.09";

  nix = {
    nixPath = [
      "nixpkgs=/etc/nixos/nixpkgs"
      "nixos=/etc/nixos/nixpkgs/nixos"
      "nixos-config=/etc/nixos/configuration.nix"
    ];
    settings.trusted-users = [ "root" "@wheel" ];
  };

}
