{ config, pkgs, ... }:

{
  imports = [
    ./config
    ./features/desktop.nix
    ./features/dvorak-swapcaps
    ./features/hplip
    ./programs
    ./programs/emacs.nix
    ./programs/gpg-agent.nix
  ];
}
