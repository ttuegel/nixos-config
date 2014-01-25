{ config, pkgs, ... }:

{
  environment.etc."fonts/conf.d/50-defaults.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <alias><family>sans-serif</family>
        <prefer><family>DejaVu Sans</family></prefer></alias>
      <alias><family>serify</family>
        <prefer><family>DejaVu Serif</family></prefer></alias>
      <alias><family>monospace</family>
        <prefer><family>DejaVu Sans Mono</family></prefer></alias>
    </fontconfig>
  '';

  environment.etc."fonts/conf.d/10-subpixel.conf".text = ''
    <?xml version='1.0'?>
    <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
    <fontconfig>
    <match target="pattern">
      <edit name="rgba" mode="append"><const>rgb</const></edit>
    </match>
    </fontconfig>
  '';

  environment.etc."fonts/conf.d/11-hinting.conf".text = ''
    <?xml version='1.0'?>
    <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
    <fontconfig>
      <match target="font">
        <edit mode="assign" name="hinting"><bool>true</bool></edit>
        <edit mode="assign" name="hintstyle"><const>hintfull</const></edit>
      </match>
    </fontconfig>
  '';

  environment.variables = {
    INFINALITY_FT_FILTER_PARAMS = "11 22 38 22 11";
    INFINALITY_FT_STEM_ALIGNMENT_STRENGTH = "25";
    INFINALITY_FT_STEM_FITTING_STRENGTH = "25";
    INFINALITY_FT_STEM_SNAPPING_SLIDING_SCALE = "40";
    INFINALITY_FT_USE_KNOWN_SETTINGS_ON_SELECTED_FONTS = "true";
    INFINALITY_FT_CHROMEOS_STYLE_SHARPENING_STRENGTH = "0";
    INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH = "5";
    INFINALITY_FT_AUTOHINT_SNAP_STEM_HEIGHT = "100";
    INFINALITY_FT_USE_VARIOUS_TWEAKS = "true";
    INFINALITY_FT_GAMMA_CORRECTION = "0 100";
    INFINALITY_FT_BRIGHTNESS = "0";
    INFINALITY_FT_CONTRAST = "0";
    INFINALITY_FT_GRAYSCALE_FILTER_STRENGTH = "0";
    INFINALITY_FT_FRINGE_FILTER_STRENGTH = "0";
    INFINALITY_FT_AUTOHINT_HORIZONTAL_STEM_DARKEN_STRENGTH = "10";
    INFINALITY_FT_AUTOHINT_VERTICAL_STEM_DARKEN_STRENGTH = "25";
    INFINALITY_FT_AUTOHINT_INCREASE_GLYPH_HEIGHTS = "true";
    QT_GRAPHICSSYSTEM = "native";
  };

  fonts.extraFonts = with pkgs; [
    dejavu_fonts
    liberation_ttf
    vistafonts
  ];
}