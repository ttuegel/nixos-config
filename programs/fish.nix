{ config, lib, pkgs, ... }:

{
  programs.fish.enable = true;
  users.users.ttuegel.shell =
    lib.mkDefault "/var/run/current-system/sw/bin/fish";
}
