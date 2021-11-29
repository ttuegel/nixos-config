{ lib, config, pkgs, ... }:

let
  caches = {
    "http://cache.nixos.org" = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
    "https://ttuegel.cachix.org" = "ttuegel.cachix.org-1:RXdy60/000ypCG8n9rpJkYdi+of5j7yj8KmwMH/nYuc=";
    "https://hercules-ci.cachix.org" = "hercules-ci.cachix.org-1:ZZeDl9Va+xe9j+KqdzoBZMFJHVQ42Uu/c/1/KMC5Lw0=";
    "https://iohk.cachix.org" = "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo=";
    "https://hydra.iohk.io" = "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=";
    "https://shajra.cachix.org" = "shajra.cachix.org-1:V0x7Wjgd/mHGk2KQwzXv8iydfIgLupbnZKLSQt5hh9o=";
    "https://cache.mercury.com" = "cache.mercury.com:yhfFlgvqtv0cAxzflJ0aZW3mbulx4+5EOZm6k3oML+I=";
  };
  extraPublicKeys = [
    "demeter-1:ty4IAZNb81Zrm+hairXv5Yc7ewAfTtv6FF1weutsQbM="
    "zeus-1:hpocFIqCGUxWFSSlvq5V0ImyCQhl+LcnCB21C7bhqjs="
    "hermes-1:wp8T4saXcXUdKaF/9inVox1SsDZ4DA2qHzvFXb+JZcI="
  ];
in

{
  nix = {
    useSandbox = true;
    binaryCaches = lib.attrNames caches;
    binaryCachePublicKeys = lib.attrValues caches ++ extraPublicKeys;
    extraOptions = ''
      gc-keep-derivations = true
      secret-key-files = /etc/nix/private-key
      experimental-features = nix-command
    '';
    nixPath = [
      "nixpkgs=/etc/nixos/nixpkgs"
      "nixos=/etc/nixos/nixpkgs/nixos"
      "nixos-config=/etc/nixos/configuration.nix"
    ];
  };
}
