{ config, lib, pkgs, ... }:

{
  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "Source Code Pro" "DejaVu Sans Mono" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
    ultimate.allowBitmaps = false;
    includeUserConf = false;
    hinting.style = "slight";
  };

  fonts.fonts = with pkgs; with lib; [
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    source-code-pro
    source-sans-pro
    source-serif-pro
    vistafonts
    corefonts
  ];

  environment.sessionVariables.LD_LIBRARY_PATH =
    let freetype = pkgs.callPackage ../freetype {}; in
    [ (lib.getLib freetype + "/lib") ];
}
