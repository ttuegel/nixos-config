{ config, pkgs, ... }:

{
  imports = [
    ./features/dvorak-swapcaps
    ./features/hplip
    ./config/desktop.nix
    ./config
    ./programs
    ./programs/emacs.nix
    ./programs/gpg-agent.nix
  ];
}
