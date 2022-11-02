{ config, agenix-cli, ... }:

let
  inherit (config.nixpkgs.localSystem) system;
  packages = agenix-cli.packages.${system};
in

{
  environment.systemPackages = [ packages.agenix-cli ];
}
