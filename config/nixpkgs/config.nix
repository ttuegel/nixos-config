pkgs:

let

  config = {
    allowBroken = true;
    allowUnfree = true;
    clementine.spotify = true;
    pulseaudio = true;
  };

  withoutGnome = drv: drv.override { withGnome = false; };

in

config // {
  packageOverrides = super: let self = super.pkgs; in
    (import ./pkgs self) // {

    alacritty = super.alacritty.overrideAttrs (attrs: {
      patches = [
        (self.fetchpatch {
          url = "https://github.com/pvaibhav/alacritty/commit/4695a9d7f400224d557f3cf542325d7d627d9dce.patch";
          sha256 = "120v1pnwwyhhrp3q94zsvw76pivd31c0xmb7k2l1pqiv5gxsspfb";
        })
      ];
    });

    networkmanager_openvpn = withoutGnome super.networkmanager_openvpn;
    networkmanager_vpnc = withoutGnome super.networkmanager_vpnc;
    networkmanager_openconnect = withoutGnome super.networkmanager_openconnect;
    networkmanager_fortisslvpn = withoutGnome super.networkmanager_fortisslvpn;
    networkmanager_pptp = withoutGnome super.networkmanager_pptp;
    networkmanager_l2tp = withoutGnome super.networkmanager_l2tp;

    # Enable OpenGL 4 support and select drivers
    mesa_drivers = self.mesaDarwinOr (
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
      patches =
        (attrs.patches or [])
        ++ [
          (self.fetchurl {
            url = "https://github.com/ttuegel/notmuch/commit/3fbc76ab83052113410a7d706099a754855fdaa9.patch";
            sha256 = "0yvzx23f41ya0jfxdn0v3h0fqh5xhfpf5i6xf5hgayvyd95kzsik";
          })
        ];
      prePatch = attrs.patchPhase or null;
      patchPhase = "patchPhase";
    });

    firefox-unwrapped = super.firefox-unwrapped.override {
      drmSupport = true;
    };

    /*
    fontconfig-penultimate = super.fontconfig-penultimate.overrideAttrs (attrs: {
      src = /home/ttuegel/fontconfig-penultimate;
    });
    */

  };
}
