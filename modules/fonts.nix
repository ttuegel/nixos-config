{ config, lib, pkgs, ... }:

{
  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "Iosevka Custom" "Hack" "Source Code Pro" "DejaVu Sans Mono" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
    allowBitmaps = false;
    allowType1 = false;
    includeUserConf = false;
  };

  fonts.fonts = with pkgs; with lib;
    [
      cm_unicode
      corefonts
      dejavu_fonts
      eb-garamond
      emacs-all-the-icons-fonts
      font-awesome_4
      gentium
      iosevka-custom
      iosevka-custom-terminal
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      vistafonts
    ]
    ++ lib.attrValues tex-gyre
    ++ lib.attrValues tex-gyre-math;

}
