{ lib, config, pkgs, ... }:

let
  caches = {
    "http://cache.nixos.org" = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
    "https://ttuegel.cachix.org" = "ttuegel.cachix.org-1:RXdy60/000ypCG8n9rpJkYdi+of5j7yj8KmwMH/nYuc=";
    "https://hercules-ci.cachix.org" = "hercules-ci.cachix.org-1:ZZeDl9Va+xe9j+KqdzoBZMFJHVQ42Uu/c/1/KMC5Lw0=";
    "https://iohk.cachix.org" = "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo=";
    "https://kore.cachix.org" = "kore.cachix.org-1:JdRLRmla/geeYkiwRBCRds0rHDgiv/heOxRQmLGDHSI=";
    "https://runtimeverification.cachix.org" = "runtimeverification.cachix.org-1:z2UVwHPthsW4qRSfcnG3veR/MFdZp8HS0f8kgacAjvA=";
    "http://mugen:5000" = "tuegel.mooo.com-1:hZ9VCbn2eRfZl3VVYxkFakWH2SSA18vDv87xxT7BKus=";
  };
in

{
  nix = {
    useSandbox = true;
    binaryCaches = lib.attrNames caches;
    binaryCachePublicKeys = lib.attrValues caches;
    trustedBinaryCaches = [
      "http://192.168.0.3:5000/"
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
