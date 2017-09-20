{ config, pkgs, ... }:

let

  inherit (pkgs) hplipWithPlugin;

in

{
  environment.systemPackages = [ hplipWithPlugin ];

  # HP printer/scanner support
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ hplipWithPlugin ];
  services.printing.enable = true;
  services.printing.drivers = [ hplipWithPlugin ];
}
