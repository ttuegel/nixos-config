{ config, pkgs, ... }:

{
  containers.quassel = {
    autoStart = true;
    config = import ../containers/quassel.nix;
  };
}
