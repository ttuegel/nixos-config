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

  iosevka-design = ''
    g = "single-storey"
    i = "serifed-tailed"
    l = "serifed-tailed"
    zero = "dotted"
    asterisk = "hex-low"
    brace = "straight"
    four = "closed"
  '';

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

      iosevka-custom = self.iosevka.override {
        set = "custom";
        privateBuildPlan = ''
          [buildPlans.iosevka-custom]
          family = "Iosevka Custom"
          spacing = "normal"
          serifs = "sans"
          no-cv-ss = true
          no-ligation = true

          [buildPlans.iosevka-custom.variants.design]
          ${iosevka-design}
        '';
      };

      iosevka-custom-terminal = self.iosevka.override {
        set = "custom";
        privateBuildPlan = ''
          [buildPlans.iosevka-custom]
          family = "Iosevka Custom Terminal"
          spacing = "term"
          serifs = "sans"
          no-cv-ss = true
          no-ligation = true

          [buildPlans.iosevka-custom.variants.design]
          ${iosevka-design}
        '';
      };

      # Aliases

      font-awesome-ttf = self.font-awesome_4;

    };
}
