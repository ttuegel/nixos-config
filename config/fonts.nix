{ config, pkgs, ... }:

{
  fonts.fontconfig = {
    defaultFonts.monospace = [ "Source Code Pro" "DejaVu Sans Mono" ];
    hinting = {
      style = "slight";
      autohint = false;
    };
    ultimate = {
      allowBitmaps = false;
      enable = true;
      rendering = pkgs.fontconfig-ultimate.rendering.ultimate-darker;
    };
    includeUserConf = false;
  };

  fonts.fonts = with pkgs; with lib; [
    dejavu_fonts
    vistafonts
    wqy_microhei
    source-code-pro
    source-sans-pro
    source-serif-pro
  ] ++ filter isDerivation (attrValues lohit-fonts);
}
