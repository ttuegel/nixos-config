{ config, lib, pkgs, ... }:

{
  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "Io Mono" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
    allowBitmaps = false;
    allowType1 = false;
    includeUserConf = false;
  };

  fonts.packages = with pkgs; with lib;
    [
      cm_unicode
      corefonts
      dejavu_fonts
      eb-garamond
      emacs-all-the-icons-fonts
      font-awesome_4
      gentium
      io-mono
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      vistafonts
    ]
    ++ lib.attrValues tex-gyre
    ++ lib.attrValues tex-gyre-math;

}
