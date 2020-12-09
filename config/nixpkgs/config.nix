pkgs:

let

  config = {
    allowBroken = true;
    allowUnfree = true;
    android_sdk.accept_license = true;
    clementine.spotify = true;
    firefox.enableBrowserpass = true;
    pulseaudio = true;
  };

in

let
  iosevka-design = [
    "v-l-italic"
    "v-i-italic"
    "v-g-singlestorey"
    "v-zero-dotted"
    "v-asterisk-high"
    "v-at-long"
    "v-brace-straight"
  ];
in

config // {
  packageOverrides = super:
    let
      self = super.pkgs;
      sources = import ./nix/sources.nix;
    in
    {

      # Extra Packages

      niv =
        let
          overlay = _: _: { inherit (import sources."niv" {}) niv; };
          nixpkgs = import self.path { overlays = [ overlay ]; config = {}; };
        in
          nixpkgs.niv;

      repos = import sources."repos";

      # Get emacsPackages from emacs-overlay.
      emacsPackages =
        (self.emacsPackagesNgFor self.emacs).overrideScope'
        (_: super: super.melpaPackages);

      iosevka-term = self.iosevka.override {
        set = "term";
        privateBuildPlan = {
          family = "Iosevka Term";
          design =
            [ "sp-fixed" ]
            ++ iosevka-design;
        };
      };

      iosevka-type = self.iosevka.override {
        set = "type";
        privateBuildPlan = {
          family = "Iosevka Type";
          design =
            [ "no-ligation" ]
            ++ iosevka-design;
        };
      };

      # Aliases

      font-awesome-ttf = self.font-awesome_4;

    };
}
