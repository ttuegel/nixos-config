{...}:

{
  imports = [
    <nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
  ];

  # Add ZFS support to kernel and userspace
  boot.supportedFilesystems = [ "zfs" ];
}
