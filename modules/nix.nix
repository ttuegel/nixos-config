{ lib, config, pkgs, ... }:

let
  caches = {
    "http://cache.nixos.org" = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
    "https://nix-community.cachix.org" = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
    "https://ttuegel.cachix.org" = "ttuegel.cachix.org-1:RXdy60/000ypCG8n9rpJkYdi+of5j7yj8KmwMH/nYuc=";
    "https://hercules-ci.cachix.org" = "hercules-ci.cachix.org-1:ZZeDl9Va+xe9j+KqdzoBZMFJHVQ42Uu/c/1/KMC5Lw0=";
    "https://cache.iog.io" = "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=";
    "https://shajra.cachix.org" = "shajra.cachix.org-1:V0x7Wjgd/mHGk2KQwzXv8iydfIgLupbnZKLSQt5hh9o=";
    "https://cache.mercury.com" = "cache.mercury.com:yhfFlgvqtv0cAxzflJ0aZW3mbulx4+5EOZm6k3oML+I=";
  };
  extraPublicKeys = [
    "zeus-1:hpocFIqCGUxWFSSlvq5V0ImyCQhl+LcnCB21C7bhqjs="
    "hermes-1:wp8T4saXcXUdKaF/9inVox1SsDZ4DA2qHzvFXb+JZcI="
    "maia-1:Fo9tkI6tOVk5ywQASNighjVAt5go/6+nGIoVrRzRgIs="
    "pollux-1:USx/G8zXmEx3kGfEqNm28KcE90jvvVUvdN0dHGRaijI="
    "pollux-2:EiBAkRxc6B3fVYPfQZAw4GIobhK7tocQ8BISx4Jq0G0="
    "bandit-1:3/GmUsRRTVknf02c9k7fbQgH1yLuTR+6kMhLHPEG/r4="
  ];
in

{
  nix = {
    settings = {
      sandbox = true;
      trusted-public-keys = lib.attrValues caches ++ extraPublicKeys;
      trusted-substituters = lib.attrNames caches;
    };
    extraOptions = ''
      gc-keep-derivations = true
      secret-key-files = /etc/nix/private-key
      experimental-features = nix-command flakes
    '';
    channel.enable = false;
  };
}
