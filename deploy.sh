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
                host="$1"
            else
                echo >&2 "Unrecognized argument: $1"; exit 1
            fi
    esac
    shift
done

[[ -n "$host" ]] || exit 1

attr_path=".#nixosConfigurations.$host.config.system.build.toplevel"
nix build "$attr_path"
result="$(nix path-info "$attr_path")"

[[ -z "$dry_run" ]] || exit 0

nix copy --to "ssh://$host" "$result"
ssh -A "$host" sudo env NIXOS_INSTALL_BOOTLOADER=1 "$result/bin/switch-to-configuration" switch
ssh -A "$host" sudo nix-env --profile /nix/var/nix/profiles/system --set "$result"
