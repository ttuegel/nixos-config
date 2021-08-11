```
nix-build nixos -A config.system.build.isoImage \
    -I nixpkgs=$HOME/nixpkgs \
    -I nixos=$HOME/nixpkgs/nixos \
    -I nixos-config=$HOME/nixos-config/hosts/rescue/configuration.nix
```
