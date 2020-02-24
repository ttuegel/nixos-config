{ config, pkgs, ... }:

{
  console.keyMap = (pkgs.callPackage ./keymap.nix {});

  services.xserver = {
    layout = "us";
    xkbVariant = "dvorak";
    xkbOptions = "ctrl:swapcaps,compose:menu";
  };
}
