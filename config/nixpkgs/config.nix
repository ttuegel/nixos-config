pkgs:

let

  config = {
    allowBroken = true;
    allowUnfree = true;
    android_sdk.accept_license = true;
    pulseaudio = true;
  };

  iosevka-design = plan-name: ''
    [buildPlans.${plan-name}.variants.design]
    g = "single-storey-serifless"
    i = "tailed-serifed"
    l = "tailed-serifed"
    zero = "dotted"
    four = "closed"
    asterisk = "hex-low"
    brace = "straight"

    [buildPlans.${plan-name}.variants.italic]
    k = "curly-serifless"
    y = "straight-turn"
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

          ${iosevka-design "iosevka-custom"}
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

          ${iosevka-design "iosevka-custom"}
        '';
      };

      # Aliases

      font-awesome-ttf = self.font-awesome_4;

    };
}
