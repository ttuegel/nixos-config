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
  packageOverrides = super: let self = super.pkgs; in
    (import ./pkgs self super) // {

    notmuch = super.notmuch.overrideAttrs (attrs: {
      version =
        let inherit (attrs) version; in
        assert (version == "0.28.4"); version;
      src = self.fetchFromGitHub {
        owner = "ttuegel";
        repo = "notmuch";
        rev = "4a4546f8cfa9956f3be53608fb07b23589a7124b";
        sha256 = "069z6y86i7d173v0nzwa037zvzfzphn5m0jp8ccv7pr9lwcfxbb7";
      };
    });

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

    /*
    fontconfig-penultimate = super.fontconfig-penultimate.overrideAttrs (attrs: {
      src = /home/ttuegel/fontconfig-penultimate;
    });
    */

    pandoc = self.haskell.lib.dontCheck super.pandoc;

  };
}
