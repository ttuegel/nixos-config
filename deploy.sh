#!/bin/sh

set -xeu
set -o pipefail

host="$(realpath $1)"; shift
destination="$1"; shift

nix build -f "$host/nixpkgs/nixos" system -I nixos-config="$host/configuration.nix"
result="$(readlink result)"
nix copy --to "ssh://$destination" "$result" --no-check-sigs
ssh "$destination" sudo "$result/bin/switch-to-configuration" switch
ssh "$destination" sudo nix-env --profile /nix/var/nix/profiles/system --set "$result"
