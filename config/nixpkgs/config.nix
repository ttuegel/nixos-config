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

config // {
  packageOverrides = super:
    let
      self = super.pkgs;
      sources = import ./nix/sources.nix;
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
      iosevka = {
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
      };
    in
    iosevka // {

      # Extra Packages

      niv =
        let
          overlay = _: _: { inherit (import sources."niv" {}) niv; };
          nixpkgs = import self.path { overlays = [ overlay ]; config = {}; };
        in
          nixpkgs.niv;

      notmuch = super.notmuch.overrideAttrs (attrs: {
        patches =
          [ ./notmuch-sync-trashed-flag.patch ]
          ++ (attrs.patches or [])
          ;
      });

      repos = import sources."repos";

      uiucthesis2014 = self.callPackage ./uiucthesis2014.nix { inherit sources; };

      # Get emacsPackages from emacs-overlay.
      emacsPackages =
        (self.emacsPackagesNgFor self.emacs).overrideScope'
        (_: super: super.melpaPackages);

      # Custom Packages

      pandoc = self.haskell.lib.dontCheck super.pandoc;

      # Aliases

      font-awesome-ttf = self.font-awesome_4;

    };
}
