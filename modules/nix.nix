{ lib, config, pkgs, ... }:

let
  caches = {
    "http://cache.nixos.org" = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
    "https://nix-community.cachix.org" = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
    "https://ttuegel.cachix.org" = "ttuegel.cachix.org-1:RXdy60/000ypCG8n9rpJkYdi+of5j7yj8KmwMH/nYuc=";
    "https://hercules-ci.cachix.org" = "hercules-ci.cachix.org-1:ZZeDl9Va+xe9j+KqdzoBZMFJHVQ42Uu/c/1/KMC5Lw0=";
    "https://iohk.cachix.org" = "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo=";
    "https://hydra.iohk.io" = "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=";
    "https://shajra.cachix.org" = "shajra.cachix.org-1:V0x7Wjgd/mHGk2KQwzXv8iydfIgLupbnZKLSQt5hh9o=";
    "https://cache.mercury.com" = "cache.mercury.com:yhfFlgvqtv0cAxzflJ0aZW3mbulx4+5EOZm6k3oML+I=";
  };
  extraPublicKeys = [
    "zeus-1:hpocFIqCGUxWFSSlvq5V0ImyCQhl+LcnCB21C7bhqjs="
    "hermes-1:wp8T4saXcXUdKaF/9inVox1SsDZ4DA2qHzvFXb+JZcI="
    "maia-1:Fo9tkI6tOVk5ywQASNighjVAt5go/6+nGIoVrRzRgIs="
    "pollux-1:USx/G8zXmEx3kGfEqNm28KcE90jvvVUvdN0dHGRaijI="
  ];
in

{
  nix = {
    settings = {
      sandbox = true;
      substituters = lib.attrNames caches;
      trusted-public-keys = lib.attrValues caches ++ extraPublicKeys;
    };
    extraOptions = ''
      gc-keep-derivations = true
      secret-key-files = /etc/nix/private-key
      experimental-features = nix-command flakes
    '';
    nixPath = [
      "nixpkgs=/etc/nixos/nixpkgs"
      "nixos=/etc/nixos/nixpkgs/nixos"
      "nixos-config=/etc/nixos/configuration.nix"
    ];
  };
}
