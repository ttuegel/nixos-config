{
  inputs.nixpkgs.url = "github:ttuegel/nixpkgs?ref=hosts/main";
  inputs.secrets = {
    # url = "git+ssh://gitolite@zeus/ttuegel/nixos-secrets?ref=main";
    url = "git+file:///home/ttuegel/nixos-config/secrets";
    flake = false;
  };

  outputs = { self, nixpkgs, secrets }: {
    nixosConfigurations.pollux = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./hosts/pollux/configuration.nix ];
      specialArgs = { inherit secrets; };
    };
  };
}
