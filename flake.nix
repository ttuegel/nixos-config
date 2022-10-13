{
  inputs.nixpkgs.url = "github:ttuegel/nixpkgs?ref=hosts/main";
  inputs.secrets = {
    url = "git+ssh://gitolite@zeus/ttuegel/nixos-secrets?ref=main";
    flake = false;
  };
  inputs.nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.05";
  inputs.emacs-config.url = "git+file:///home/ttuegel/emacs-config";

  outputs = { self, nixpkgs, secrets, nixpkgs-stable, emacs-config }: {
    nixosConfigurations = {

      # Workstations

      dioscuri = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/dioscuri/configuration.nix ];
        specialArgs = { inherit secrets; };
      };

      hermes = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/hermes/configuration.nix ];
        specialArgs = { inherit emacs-config secrets; };
      };

      maia = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/maia/configuration.nix ];
        specialArgs = { inherit emacs-config secrets; };
      };

      pollux = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/pollux/configuration.nix ];
        specialArgs = { inherit emacs-config secrets; };
      };

      # Special purpose

      micro = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/micro/configuration.nix ];
        specialArgs = { inherit emacs-config secrets; };
      };

      rescue = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/rescue/configuration.nix ];
        specialArgs = { inherit emacs-config secrets; };
      };

      # Servers

      olympus = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/olympus/configuration.nix ];
        specialArgs = { inherit emacs-config secrets; };
      };

      zeus = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/zeus/configuration.nix ];
        specialArgs = { inherit secrets; };
      };

    };
  };
}
