{ config, pkgs, ... }:

{
  i18n = {
    consoleKeyMap = (pkgs.callPackage ./keymap.nix {});
  };
}
