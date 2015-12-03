{ config, ... }:

let
  pkgs = import ./nixpkgs { inherit (config.nixpkgs) config; };
in

{
  environment.systemPackages = [
    pkgs.hplipWithPlugin
  ];

  # HP printer/scanner support
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplipWithPlugin ];
}
