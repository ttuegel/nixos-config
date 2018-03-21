pkgs:

let

  config = {
    allowBroken = true;
    allowUnfree = true;
    clementine.spotify = true;
    firefox.enableBrowserpass = true;
    pulseaudio = true;
  };

  withoutGnome = drv: drv.override { withGnome = false; };

in

config // {
  packageOverrides = super: let self = super.pkgs; in
    (import ./pkgs self super) // {

    networkmanager_openvpn = withoutGnome super.networkmanager_openvpn;
    networkmanager_vpnc = withoutGnome super.networkmanager_vpnc;
    networkmanager_openconnect = withoutGnome super.networkmanager_openconnect;
    networkmanager_fortisslvpn = withoutGnome super.networkmanager_fortisslvpn;
    networkmanager_pptp = withoutGnome super.networkmanager_pptp;
    networkmanager_l2tp = withoutGnome super.networkmanager_l2tp;

    # Enable OpenGL 4 support and select drivers
    mesa_drivers = self.libGLDarwinOr (
      let mo = self.mesa_noglu.override {
        grsecEnabled = false;
        enableTextureFloats = true;
        galliumDrivers = [ "i915" "radeonsi" ];
        driDrivers = [ "i965" ];
        vulkanDrivers = [ "intel" ];
      };
      in mo.drivers
    );

    haskellPackages =
      let inherit (self.haskell) lib; in
      super.haskellPackages.override {
      overrides = self: super: {
        aeson_0_11_3_0 = lib.doJailbreak super.aeson_0_11_3_0;
      };
    };

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
