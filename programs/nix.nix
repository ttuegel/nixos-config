{ config, pkgs, ... }:

{
  nix = {
    useSandbox = true;
    binaryCaches = [
      "http://cache.nixos.org/"
      "https://hie-nix.cachix.org"
      "https://all-hies.cachix.org"
    ];
    trustedBinaryCaches = [
      "http://192.168.0.3:5000/"
    ];
    binaryCachePublicKeys = [
      "tuegel.mooo.com-1:hZ9VCbn2eRfZl3VVYxkFakWH2SSA18vDv87xxT7BKus="
      "demeter.ttuegel:ff3U2jUXBfWczEi0WI8qUyYHfZYTHtnHzL6f2Q17wg0="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hie-nix.cachix.org-1:EjBSHzF6VmDnzqlldGXbi0RM3HdjfTU3yDRi9Pd0jTY="
      "all-hies.cachix.org-1:JjrzAOEUsD9ZMt8fdFbzo3jNAyEWlPAwdVuHw4RD43k="
    ];
    extraOptions = ''
      build-cores = 0
      gc-keep-derivations = true
    '';
    nixPath = [
      "nixpkgs=/etc/nixos/nixpkgs"
      "nixos=/etc/nixos/nixpkgs/nixos"
      "nixos-config=/etc/nixos/configuration.nix"
    ];
  };
}
