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
      src = self.fetchFromGitHub {
        owner = "ttuegel";
        repo = "notmuch";
        rev = "49fc15f65327fa63f54a33415a443d116d8cd962";
        sha256 = "0p5x55qri8yrp65v65d1fjrqy3c3kv29sd3q2bvw71i0cd7cpl8l";
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

  };
}
