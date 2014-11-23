{ config, lib, pkgs, ... }:

with lib;

let fontconfigBool = x: if x then "true" else "false";
    upstreamConf = "${pkgs.fontconfig}/etc/fonts/conf.d";
in
{

  options = {

    fonts = {

      fontconfig = {

        enable = mkOption {
          type = types.bool;
          default = true;
          description = ''
            If enabled, a Fontconfig configuration file will be built
            pointing to a set of default fonts.  If you don't care about
            running X11 applications or any other program that uses
            Fontconfig, you can turn this option off and prevent a
            dependency on all those fonts.
          '';
        };

        oldLocalConf = mkOption {
          type = types.string;
          default = ''
            <?xml version='1.0'?>
            <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
            <fontconfig>

              <!-- Settings for all fonts. -->
              <match target="font">

                <!-- Set the default hinting style. -->
                <edit mode="assign" name="hintstyle">
                  <const>hintslight</const>
                </edit>

              </match>

            </fontconfig>
          '';
          description = ''
            System-wide Fontconfig settings in
            <filename>/etc/fonts/local.conf</filename>.
          '';
        };

        localConf = mkOption {
          type = types.string;
          default = ''
            <?xml version='1.0'?>
            <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
            <fontconfig>

              <!-- Settings for all fonts. -->
              <match target="font">

                <!-- Set the default hinting style. -->
                <edit mode="assign" name="hintstyle">
                  <const>hintslight</const>
                </edit>

              </match>

            </fontconfig>
          '';
          description = ''
            System-wide Fontconfig settings in
            <filename>/etc/fonts/*/local.conf</filename>.
          '';
        };

      };


    };

  };


  config =
    let fontconfig = config.fonts.fontconfig;
    in mkIf fontconfig.enable {

      # Fontconfig 2.10 backward compatibility

      # Bring in the default (upstream) fontconfig configuration, only for fontconfig 2.10
      environment.etc."fonts/fonts.conf".source = pkgs.makeFontsConf {
        fontconfig = pkgs.fontconfig_210;
        fontDirectories = config.fonts.fonts;
      };
      environment.etc."fonts/local.conf".text = fontconfig.oldLocalConf;

      # Versioned fontconfig > 2.10. Take shared fonts.conf from fontconfig.
      # Otherwise specify only font directories.
      environment.etc."fonts/${pkgs.fontconfig.configVersion}/fonts.conf".source =
        "${pkgs.fontconfig}/etc/fonts/fonts.conf";
      environment.etc."fonts/${pkgs.fontconfig.configVersion}/conf.d/00-nixos.conf".text =
        ''
          <?xml version='1.0'?>
          <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
          <fontconfig>

            <!-- Font directories -->
            ${concatStringsSep "\n" (map (font: "<dir>${font}</dir>") config.fonts.fonts)}

          </fontconfig>
        '';
      environment.etc."fonts/${pkgs.fontconfig.configVersion}/local.conf".text =
        fontconfig.localConf;

      environment.systemPackages = [ pkgs.fontconfig ];

    };

}
