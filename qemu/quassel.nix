{ config, pkgs, ... }:

{

  networking = {
    hostName = "quassel";
    firewall.allowedTCPPorts = [ 4242 ];
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql94;
  };

  services.quassel = {
    enable = true;
    interface = "0.0.0.0";
  };
  systemd.services.quassel.after = [ "postgresql.service" ];

  services.openssh.enable = true;

  users.mutableUsers = false;
  users.extraUsers.root.openssh.authorizedKeys.keyFiles = [
    "/etc/nixos/id_gpg.pub"
  ];

  virtualisation = {
    diskImage = "/var/lib/qemu/quassel.qcow2";
    diskSize = 4096;
    qemu = {
      options = [
        # true headless mode
        "-vga none" "-nographic"
      ];
      networkingOptions = [
        "-net nic,vlan=0,model=virtio"
        # tap device created by NixOS/systemd
        "-net tap,vlan=0,ifname=tap-quassel,script=no,downscript=no"
      ];
    };
  };
}
