#!/bin/sh

set -xeu
set -o pipefail

dry_run=

while [[ $# -gt 0 ]]
do
    case $1 in
        "--dry-run")
            dry_run=1
            ;;
        *)
            if ! [[ -v host ]]
            then
                host="$(realpath $1)"
            elif ! [[ -v destination ]]
            then
                destination="$1"
            else
                echo >&2 "Unrecognized argument: $1"; exit 1
            fi
    esac
    shift
done

[[ -n "$host" ]] || exit 1
[[ -n "$destination" ]] || exit 1

nix build -f "$host/nixpkgs/nixos" system -I nixos-config="$host/configuration.nix"
result="$(readlink result)"

[[ -z "$dry_run" ]] || exit 0

nix copy --to "ssh://$destination" "$result" --no-check-sigs
ssh "$destination" sudo env NIXOS_INSTALL_BOOTLOADER=1 "$result/bin/switch-to-configuration" switch
ssh "$destination" sudo nix-env --profile /nix/var/nix/profiles/system --set "$result"
