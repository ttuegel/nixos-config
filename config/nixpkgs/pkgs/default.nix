self: with self;

{
  feast = callPackage ./feast {
    openblas = openblasCompat;
  };

  otfcc = callPackage ./otfcc {};

  iosevka-term = callPackage ./iosevka {
    set = "term";
    design = [
      "term" "v-l-italic" "v-i-italic" "v-g-singlestorey" "v-zero-dotted"
      "v-asterisk-high" "v-at-long" "v-brace-straight"
    ];
  };

  iosevka-type = callPackage ./iosevka {
    set = "type";
    design = [
      "type" "v-l-italic" "v-i-italic" "v-g-singlestorey" "v-zero-dotted"
      "v-asterisk-high" "v-at-long" "v-brace-straight"
    ];
  };
}
