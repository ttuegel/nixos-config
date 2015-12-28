{ config, pkgs, ... }:

{
  i18n = {
    consoleKeyMap = (pkgs.callPackage ./keymap.nix {});
  };

  services.xserver = {
    layout = "us";
    xkbVariant = "dvorak";
    xkbOptions = "ctrl:swapcaps,compose:menu";
  };
}
