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
    in {

      # Extra Packages

      lorri = import sources."lorri" { inherit pkgs; };

      niv =
        let
          overlay = _: _: { inherit (import sources."niv" {}) niv; };
          nixpkgs = import self.path { overlays = [ overlay ]; config = {}; };
        in
          nixpkgs.niv;

      notmuch = super.notmuch.overrideAttrs (attrs: {
        version =
          let inherit (attrs) version; in
          assert (version == "0.29.2"); version;
        src = sources."notmuch";
      });

      repos = import sources."repos";

      uiucthesis2014 = self.callPackage ./uiucthesis2014.nix { inherit sources; };

      # Get emacsPackages from emacs-overlay.
      emacsPackages =
        (self.emacsPackagesNgFor self.emacs).overrideScope'
        (_: super: super.melpaPackages);

      # Custom Packages

      iosevka-term = self.iosevka.override {
        set = "term";
        design = [
          "term" "v-l-italic" "v-i-italic" "v-g-singlestorey" "v-zero-dotted"
          "v-asterisk-high" "v-at-long" "v-brace-straight"
        ];
      };

      iosevka-type = self.iosevka.override {
        set = "type";
        design = [
          "type" "v-l-italic" "v-i-italic" "v-g-singlestorey" "v-zero-dotted"
          "v-asterisk-high" "v-at-long" "v-brace-straight"
        ];
      };

      pandoc = self.haskell.lib.dontCheck super.pandoc;

      # Aliases

      font-awesome-ttf = self.font-awesome_4;

    };
}
