{ config, pkgs, ... }:

{
  programs.zsh.enable = true;
  users.defaultUserShell = "/var/run/current-system/sw/bin/bash";
}
