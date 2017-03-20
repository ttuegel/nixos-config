{ config, pkgs, ... }:

let

  channel = pkgs.fetchFromGitHub {
    owner = "nixos";
    repo = "nixpkgs-channels";
    rev = "2839b101f927be5daab7948421de00a6f6c084ae";
    sha256 = "0a863cc5462gn1vws87d4qn45zk22m64ri1ip67w0b1a9bmymqdh";
  };

  inherit (import channel { inherit (config.nixpkgs) config; })
    hplipWithPlugin;

in

{
  environment.systemPackages = [
    hplipWithPlugin
  ];

  # HP printer/scanner support
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ hplipWithPlugin ];
  services.printing.enable = true;
  services.printing.drivers = [ hplipWithPlugin ];
}
