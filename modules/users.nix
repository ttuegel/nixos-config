{ config, lib, secrets, pkgs, ... }:

let
  readHashedPassword = lib.fileContents;
in

{
  users.mutableUsers = false;

  users.users = {
    ttuegel = {
      uid = 1000;
      isNormalUser = true;
      description = "Thomas Tuegel";
      home = "/home/ttuegel";
      createHome = true;
      group = "users";
      extraGroups = [ "adbusers" "lp" "lxd" "vboxusers" "wheel" ];
      hashedPassword = readHashedPassword "${secrets}/users/ttuegel/hashed-password";
      shell = "/run/current-system/sw/bin/fish";
      openssh.authorizedKeys.keys =
        [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfJ6ioMR5fAtMtjLDxE/Pwq+5M5qmox1/4OyLSNFjq3b5WUftkpQ7aT0x8Rxfdt5H/XmJK4OMAQv2jT7GmsYaLQUL9MQjN+/NLxEOhPu6geURMPaq/VkFWAHlGkpeAB/T4Fl9OanETa1hkcowZwjA4rxNxonxKyNveH16tNhAurHv6Fz57KP28ne6GX9nN3lP0EgaGP+y9ZRqWW5OYZ5+A5AjKxhQ1qu2ivwfLU+9KXaa7HY6YIPrJKHcmxhAU1H7FEIs5o/EnHKVllLbNQn3B3fJp6tCVzmUHEmmS2/cuoDd16+vk98uB0b3kuGccykwDOJTZpCNV6v9dY8ptqHx1 (none)"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBYJqbx0vAxlcvvEX7UKBezvO8BK2Hl3Yzw+KKGxsup2 ttuegel@mailbox.org"
        ];
    };
    root.hashedPassword = readHashedPassword "${secrets}/users/root/hashed-password";
  };

  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "4096";
    }
  ];

}
