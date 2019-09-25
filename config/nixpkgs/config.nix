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
        assert (version == "0.29.1"); version;
      src = self.fetchFromGitHub {
        owner = "ttuegel";
        repo = "notmuch";
        rev = "bfd8601219aa8e422332eba88168249bbdf0680f";
        sha256 = "1c7vpz4mcavr77z87gwrishcrly9wdmwb4wb2vxw0qkma30qmvx2";
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
