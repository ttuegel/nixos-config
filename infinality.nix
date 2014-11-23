{ config, pkgs, ... }:

with pkgs.lib;

let fontconfigBool = x: if x then "true" else "false";
    infinalityPresets = rec {
      custom = {};

      default = {
        INFINALITY_FT_FILTER_PARAMS="11 22 38 22 11";
        INFINALITY_FT_GRAYSCALE_FILTER_STRENGTH="0";
        INFINALITY_FT_FRINGE_FILTER_STRENGTH="0";
        INFINALITY_FT_AUTOHINT_HORIZONTAL_STEM_DARKEN_STRENGTH="10";
        INFINALITY_FT_AUTOHINT_VERTICAL_STEM_DARKEN_STRENGTH="25";
        INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="10";
        INFINALITY_FT_CHROMEOS_STYLE_SHARPENING_STRENGTH="0";
        INFINALITY_FT_STEM_ALIGNMENT_STRENGTH="25";
        INFINALITY_FT_STEM_FITTING_STRENGTH="25";
        INFINALITY_FT_GAMMA_CORRECTION="0 100";
        INFINALITY_FT_BRIGHTNESS="0";
        INFINALITY_FT_CONTRAST="0";
        INFINALITY_FT_USE_VARIOUS_TWEAKS="true";
        INFINALITY_FT_AUTOHINT_INCREASE_GLYPH_HEIGHTS="true";
        INFINALITY_FT_AUTOHINT_SNAP_STEM_HEIGHT="100";
        INFINALITY_FT_STEM_SNAPPING_SLIDING_SCALE="40";
        INFINALITY_FT_USE_KNOWN_SETTINGS_ON_SELECTED_FONTS="true";
        INFINALITY_FT_GLOBAL_EMBOLDEN_X_VALUE="0";
        INFINALITY_FT_GLOBAL_EMBOLDEN_Y_VALUE="0";
        INFINALITY_FT_BOLD_EMBOLDEN_X_VALUE="0";
        INFINALITY_FT_BOLD_EMBOLDEN_Y_VALUE="0";
      };

      osx = default // {
        INFINALITY_FT_FILTER_PARAMS="03 32 38 32 03";
        INFINALITY_FT_GRAYSCALE_FILTER_STRENGTH="25";
        INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="0";
        INFINALITY_FT_STEM_ALIGNMENT_STRENGTH="0";
        INFINALITY_FT_STEM_FITTING_STRENGTH="0";
        INFINALITY_FT_GAMMA_CORRECTION="1000 80";
        INFINALITY_FT_BRIGHTNESS="10";
        INFINALITY_FT_CONTRAST="20";
        INFINALITY_FT_USE_VARIOUS_TWEAKS="false";
        INFINALITY_FT_AUTOHINT_INCREASE_GLYPH_HEIGHTS="false";
        INFINALITY_FT_AUTOHINT_SNAP_STEM_HEIGHT="0";
        INFINALITY_FT_STEM_SNAPPING_SLIDING_SCALE="0";
        INFINALITY_FT_USE_KNOWN_SETTINGS_ON_SELECTED_FONTS="false";
        INFINALITY_FT_GLOBAL_EMBOLDEN_Y_VALUE="8";
        INFINALITY_FT_BOLD_EMBOLDEN_X_VALUE="16";
      };

      ipad = default // {
        INFINALITY_FT_FILTER_PARAMS="00 00 100 00 00";
        INFINALITY_FT_GRAYSCALE_FILTER_STRENGTH="100";
        INFINALITY_FT_AUTOHINT_HORIZONTAL_STEM_DARKEN_STRENGTH="0";
        INFINALITY_FT_AUTOHINT_VERTICAL_STEM_DARKEN_STRENGTH="0";
        INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="0";
        INFINALITY_FT_STEM_ALIGNMENT_STRENGTH="0";
        INFINALITY_FT_STEM_FITTING_STRENGTH="0";
        INFINALITY_FT_GAMMA_CORRECTION="1000 80";
        INFINALITY_FT_USE_VARIOUS_TWEAKS="false";
        INFINALITY_FT_AUTOHINT_INCREASE_GLYPH_HEIGHTS="false";
        INFINALITY_FT_AUTOHINT_SNAP_STEM_HEIGHT="0";
        INFINALITY_FT_STEM_SNAPPING_SLIDING_SCALE="0";
        INFINALITY_FT_USE_KNOWN_SETTINGS_ON_SELECTED_FONTS="false";
      };

      ubuntu = default // {
        INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="0";
        INFINALITY_FT_STEM_ALIGNMENT_STRENGTH="0";
        INFINALITY_FT_STEM_FITTING_STRENGTH="0";
        INFINALITY_FT_GAMMA_CORRECTION="1000 80";
        INFINALITY_FT_BRIGHTNESS="-10";
        INFINALITY_FT_CONTRAST="15";
        INFINALITY_FT_USE_VARIOUS_TWEAKS="false";
        INFINALITY_FT_AUTOHINT_INCREASE_GLYPH_HEIGHTS="false";
        INFINALITY_FT_AUTOHINT_SNAP_STEM_HEIGHT="0";
        INFINALITY_FT_STEM_SNAPPING_SLIDING_SCALE="0";
        INFINALITY_FT_USE_KNOWN_SETTINGS_ON_SELECTED_FONTS="false";
      };

      linux = default // {
        INFINALITY_FT_FILTER_PARAMS="06 25 44 25 06";
        INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="0";
        INFINALITY_FT_STEM_ALIGNMENT_STRENGTH="0";
        INFINALITY_FT_STEM_FITTING_STRENGTH="0";
        INFINALITY_FT_AUTOHINT_INCREASE_GLYPH_HEIGHTS="false";
        INFINALITY_FT_AUTOHINT_SNAP_STEM_HEIGHT="100";
        INFINALITY_FT_USE_KNOWN_SETTINGS_ON_SELECTED_FONTS="false";
      };

      winxplight = default // {
        INFINALITY_FT_FILTER_PARAMS="06 25 44 25 06";
        INFINALITY_FT_FRINGE_FILTER_STRENGTH="100";
        INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="65";
        INFINALITY_FT_STEM_ALIGNMENT_STRENGTH="15";
        INFINALITY_FT_STEM_FITTING_STRENGTH="15";
        INFINALITY_FT_GAMMA_CORRECTION="1000 120";
        INFINALITY_FT_BRIGHTNESS="20";
        INFINALITY_FT_CONTRAST="30";
        INFINALITY_FT_AUTOHINT_INCREASE_GLYPH_HEIGHTS="false";
        INFINALITY_FT_STEM_SNAPPING_SLIDING_SCALE="30";
      };

      win7light = default // {
        INFINALITY_FT_FILTER_PARAMS="20 25 38 25 05";
        INFINALITY_FT_FRINGE_FILTER_STRENGTH="100";
        INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="100";
        INFINALITY_FT_STEM_ALIGNMENT_STRENGTH="0";
        INFINALITY_FT_STEM_FITTING_STRENGTH="0";
        INFINALITY_FT_GAMMA_CORRECTION="1000 160";
        INFINALITY_FT_CONTRAST="20";
        INFINALITY_FT_AUTOHINT_INCREASE_GLYPH_HEIGHTS="false";
        INFINALITY_FT_STEM_SNAPPING_SLIDING_SCALE="30";
      };

      winxp = default // {
        INFINALITY_FT_FILTER_PARAMS="06 25 44 25 06";
        INFINALITY_FT_FRINGE_FILTER_STRENGTH="100";
        INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="65";
        INFINALITY_FT_STEM_ALIGNMENT_STRENGTH="15";
        INFINALITY_FT_STEM_FITTING_STRENGTH="15";
        INFINALITY_FT_GAMMA_CORRECTION="1000 120";
        INFINALITY_FT_BRIGHTNESS="10";
        INFINALITY_FT_CONTRAST="20";
        INFINALITY_FT_AUTOHINT_INCREASE_GLYPH_HEIGHTS="false";
        INFINALITY_FT_STEM_SNAPPING_SLIDING_SCALE="30";
      };

      win7 = default // {
        INFINALITY_FT_FILTER_PARAMS="20 25 42 25 06";
        INFINALITY_FT_FRINGE_FILTER_STRENGTH="100";
        INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="65";
        INFINALITY_FT_STEM_ALIGNMENT_STRENGTH="0";
        INFINALITY_FT_STEM_FITTING_STRENGTH="0";
        INFINALITY_FT_GAMMA_CORRECTION="1000 120";
        INFINALITY_FT_BRIGHTNESS="10";
        INFINALITY_FT_CONTRAST="20";
        INFINALITY_FT_AUTOHINT_INCREASE_GLYPH_HEIGHTS="false";
        INFINALITY_FT_STEM_SNAPPING_SLIDING_SCALE="0";
      };

      vanilla = default // {
        INFINALITY_FT_FILTER_PARAMS="06 25 38 25 06";
        INFINALITY_FT_AUTOHINT_HORIZONTAL_STEM_DARKEN_STRENGTH="0";
        INFINALITY_FT_AUTOHINT_VERTICAL_STEM_DARKEN_STRENGTH="0";
        INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="0";
        INFINALITY_FT_STEM_ALIGNMENT_STRENGTH="0";
        INFINALITY_FT_STEM_FITTING_STRENGTH="0";
        INFINALITY_FT_USE_VARIOUS_TWEAKS="false";
        INFINALITY_FT_AUTOHINT_INCREASE_GLYPH_HEIGHTS="false";
        INFINALITY_FT_AUTOHINT_SNAP_STEM_HEIGHT="0";
        INFINALITY_FT_STEM_SNAPPING_SLIDING_SCALE="0";
        INFINALITY_FT_USE_KNOWN_SETTINGS_ON_SELECTED_FONTS="false";
      };

      classic = default // {
        INFINALITY_FT_FILTER_PARAMS="06 25 38 25 06";
        INFINALITY_FT_AUTOHINT_HORIZONTAL_STEM_DARKEN_STRENGTH="0";
        INFINALITY_FT_AUTOHINT_VERTICAL_STEM_DARKEN_STRENGTH="0";
        INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="0";
        INFINALITY_FT_STEM_ALIGNMENT_STRENGTH="0";
        INFINALITY_FT_STEM_FITTING_STRENGTH="0";
        INFINALITY_FT_STEM_SNAPPING_SLIDING_SCALE="0";
        INFINALITY_FT_USE_KNOWN_SETTINGS_ON_SELECTED_FONTS="false";
      };

      nudge = default // {
        INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="0";
        INFINALITY_FT_STEM_SNAPPING_SLIDING_SCALE="30";
        INFINALITY_FT_USE_KNOWN_SETTINGS_ON_SELECTED_FONTS="false";
      };

      push = default // {
        INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="0";
        INFINALITY_FT_STEM_ALIGNMENT_STRENGTH="75";
        INFINALITY_FT_STEM_FITTING_STRENGTH="50";
        INFINALITY_FT_STEM_SNAPPING_SLIDING_SCALE="30";
      };

      infinality = default // {
        INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="5";
      };

      shove = default // {
        INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="0";
        INFINALITY_FT_STEM_ALIGNMENT_STRENGTH="100";
        INFINALITY_FT_STEM_FITTING_STRENGTH="100";
        INFINALITY_FT_STEM_SNAPPING_SLIDING_SCALE="0";
      };

      sharpened = default // {
        INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="65";
      };

      disabled = default // {
        INFINALITY_FT_FILTER_PARAMS="";
        INFINALITY_FT_GRAYSCALE_FILTER_STRENGTH="";
        INFINALITY_FT_FRINGE_FILTER_STRENGTH="";
        INFINALITY_FT_AUTOHINT_HORIZONTAL_STEM_DARKEN_STRENGTH="";
        INFINALITY_FT_AUTOHINT_VERTICAL_STEM_DARKEN_STRENGTH="";
        INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="";
        INFINALITY_FT_CHROMEOS_STYLE_SHARPENING_STRENGTH="";
        INFINALITY_FT_STEM_ALIGNMENT_STRENGTH="";
        INFINALITY_FT_STEM_FITTING_STRENGTH="";
        INFINALITY_FT_GAMMA_CORRECTION="0 100";
        INFINALITY_FT_BRIGHTNESS="0";
        INFINALITY_FT_CONTRAST="0";
        INFINALITY_FT_USE_VARIOUS_TWEAKS="false";
        INFINALITY_FT_AUTOHINT_INCREASE_GLYPH_HEIGHTS="false";
        INFINALITY_FT_AUTOHINT_SNAP_STEM_HEIGHT="";
        INFINALITY_FT_STEM_SNAPPING_SLIDING_SCALE="";
        INFINALITY_FT_USE_KNOWN_SETTINGS_ON_SELECTED_FONTS="false";
        INFINALITY_FT_GLOBAL_EMBOLDEN_X_VALUE="0";
        INFINALITY_FT_GLOBAL_EMBOLDEN_Y_VALUE="0";
        INFINALITY_FT_BOLD_EMBOLDEN_X_VALUE="0";
        INFINALITY_FT_BOLD_EMBOLDEN_Y_VALUE="0";
      };
    };
in
{

  options = {

    fonts = {

      infinality = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = ''
            Enable Infinality font rendering. Infinality is a set of patches
            for FreeType which implement subpixel rendering. This option
            enables the Fontconfig settings recommended for Infinality.
          '';
        };

        extraConf = mkOption {
          type = types.string;
          default = ''
            <!-- Uncomment this to reject all bitmap fonts -->
            <!-- Make sure to run this as root if having problems:  fc-cache -f -->
            <!--
            <selectfont>
              <rejectfont>
                <pattern>
                  <patelt name="scalable" >
                    <bool>false</bool>
                  </patelt>
                </pattern>
              </rejectfont>
            </selectfont>
            -->

            <!-- Ban Type-1 fonts because they render poorly -->
            <!-- Comment this out to allow all Type 1 fonts -->
            <selectfont>
              <rejectfont>
                <pattern>
                  <patelt name="fontformat" >
                    <string>Type 1</string>
                  </patelt>
                </pattern>
              </rejectfont>
            </selectfont>

            <!-- Globally use embedded bitmaps in fonts like Calibri? -->
            <match target="font" >
              <edit name="embeddedbitmap" mode="assign">
                <bool>false</bool>
              </edit>
            </match>

            <!-- Substitute truetype fonts in place of bitmap ones? -->
            <match target="pattern" >
              <edit name="prefer_outline" mode="assign">
                <bool>true</bool>
              </edit>
            </match>

            <!-- Do font substitutions for the set style? -->
            <!-- NOTE: Custom substitutions in 42-repl-global.conf will still be done -->
            <!-- NOTE: Corrective substitutions will still be done -->
            <match target="pattern" >
              <edit name="do_substitutions" mode="assign">
                <bool>true</bool>
              </edit>
            </match>

            <!-- Make (some) monospace/coding TTF fonts render as bitmaps? -->
            <!-- courier new, andale mono, monaco, etc. -->
            <match target="pattern" >
              <edit name="bitmap_monospace" mode="assign">
                <bool>false</bool>
              </edit>
            </match>

            <!-- Force autohint always -->
            <!-- Useful for debugging and for free software purists -->
            <match target="font">
              <edit name="force_autohint" mode="assign">
                <bool>false</bool>
              </edit>
            </match>

            <!-- Set DPI.  dpi should be set in ~/.Xresources to 96 -->
            <!-- Setting to 72 here makes the px to pt conversions work better (Chrome) -->
            <!-- Some may need to set this to 96 though -->
            <match target="pattern">
              <edit name="dpi" mode="assign">
                <double>96</double>
              </edit>
            </match>

            <!-- Use Qt subpixel positioning on autohinted fonts? -->
            <!-- This only applies to Qt and autohinted fonts. Qt determines subpixel positioning based on hintslight vs. hintfull, -->
            <!--   however infinality patches force slight hinting inside freetype, so this essentially just fakes out Qt. -->
            <!-- Should only be set to true if you are not doing any stem alignment or fitting in environment variables -->
            <match target="pattern" >
              <edit name="qt_use_subpixel_positioning" mode="assign">
                <bool>false</bool>
              </edit>
            </match>
          '';
          description = ''
            Extra configuration options from Infinality.
          '';
        };

        style = mkOption {
          type = types.string;
          default = "infinality";
          description = ''
            Select from Infinality Fontconfig presets. Must be one of
            <literal>infinality</literal>,
            <literal>linux</literal>,
            <literal>osx</literal>,
            <literal>osx2</literal>,
            <literal>win7</literal>,
            <literal>win98</literal>, or
            <literal>winxp</literal>.
          '';
        };

        freetypeStyle = mkOption {
          type = types.string;
          default = "default";
          description = ''
            Select from Infinality FreeType presets. Must be one of
            <literal>default</literal>,
            <literal>osx</literal>,
            <literal>ipad</literal>,
            <literal>ubuntu</literal>,
            <literal>linux</literal>,
            <literal>winxplight</literal>,
            <literal>win7light</literal>,
            <literal>winxp</literal>,
            <literal>win7</literal>,
            <literal>vanilla</literal>,
            <literal>classic</literal>,
            <literal>nudge</literal>,
            <literal>push</literal>,
            <literal>shove</literal>,
            <literal>sharpened</literal>,
            <literal>infinality</literal>,
            <literal>custom</literal>, or
            <literal>disabled</literal>.
            <literal>custom</literal> does not set any environment variables;
            you must set them yourself to activate Infinality.
          '';
        };

      };
    };

  };


  config =
    let fontconfig = config.fonts.fontconfig;
        infinality = config.fonts.infinality;
    in mkIf config.fonts.fontconfig.enable {

      environment.etc."fonts/infinality/infinality.conf" = {
        text =
          if infinality.enable
            then ''
              <?xml version='1.0'?>
              <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
              <fontconfig>

                ${infinality.extraConf}

                <include>${pkgs.fontconfig_210}/etc/fonts/infinality/styles.conf.avail/${infinality.style}</include>

              </fontconfig>
            ''
            else ''
              <?xml version='1.0'?>
              <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
              <fontconfig>
                <!-- Empty file to prevent loading default upstream Infinality config -->
              </fontconfig>
            '';
      };

      environment.etc."fonts/${pkgs.fontconfig.configVersion}/infinality/infinality.conf" = {
        text =
          if infinality.enable
            then ''
              <?xml version='1.0'?>
              <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
              <fontconfig>

                ${infinality.extraConf}

                <include>${pkgs.fontconfig}/etc/fonts/infinality/styles.conf.avail/${infinality.style}</include>

              </fontconfig>
            ''
            else ''
              <?xml version='1.0'?>
              <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
              <fontconfig>
                <!-- Empty file to prevent loading default upstream Infinality config -->
              </fontconfig>
            '';
      };

      environment.variables =
        if infinality.enable
          then getAttr infinality.freetypeStyle infinalityPresets
          else infinalityPresets.disabled;

    };

}
