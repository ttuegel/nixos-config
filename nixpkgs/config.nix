pkgs:

let

  config = {
    allowBroken = true;
    allowUnfree = true;
    android_sdk.accept_license = true;
    pulseaudio = true;
  };

  io-mono = ''
    [buildPlans.iosevka-io-mono]
    family = "Io Mono"
    spacing = "fontconfig-mono"
    serifs = "sans"
    no-cv-ss = true
    export-glyph-names = false
    no-ligation = true

    [buildPlans.iosevka-io-mono.variants.design]
    i = "tailed-serifed"
    l = "tailed-serifed"
    zero = "dotted"
    four = "closed"
    asterisk = "hex-low"
    brace = "straight"

    [buildPlans.iosevka-io-mono.variants.italic]
    k = "curly-serifless"

    [buildPlans.iosevka-io-mono.weights.light]
    shape = 300
    menu = 300
    css = 300

    [buildPlans.iosevka-io-mono.weights.regular]
    shape = 400
    menu = 400
    css = 400

    [buildPlans.iosevka-io-mono.weights.bold]
    shape = 700
    menu = 700
    css = 700
  '';

in

config // {
  packageOverrides = super:
    let
      self = super.pkgs;
    in
    {

      # Get emacsPackages from emacs-overlay.
      emacsPackages =
        (self.emacsPackagesNgFor self.emacs).overrideScope'
        (_: super: super.melpaPackages);

      io-mono = self.iosevka.override {
        set = "io-mono";
        privateBuildPlan = io-mono;
      };

      # Aliases

      font-awesome-ttf = self.font-awesome_4;

    };
}
