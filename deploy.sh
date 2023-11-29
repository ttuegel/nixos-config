#!/bin/sh

set -xeu
set -o pipefail

build_host=
dry_run=
target_host=

while [[ $# -gt 0 ]]
do
    case $1 in
        "--build-host")
            shift
            build_host="$1"
            ;;
        "--dry-run")
            dry_run=1
            ;;
        "--target-host")
            shift
            target_host="$1"
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

if [[ -z "$target_host" ]]
then
    target_host="$host"
fi

attr_path=".#nixosConfigurations.$host.config.system.build.toplevel"
drv_path="$(nix path-info --derivation "$attr_path")"

if [[ -n "$build_host" ]]
then
    nix copy --derivation --to "ssh://$build_host" "$attr_path"
    ssh -A "$build_host" nix build "$drv_path"
    result="$(ssh -A "$build_host" nix path-info "$drv_path")"
else
    nix build "$attr_path"
    result="$(nix path-info "$attr_path")"
fi

[[ -z "$dry_run" ]] || exit 0

if [[ -n "$build_host" ]]
then
    ssh -A "$build_host" nix copy --to "ssh://$target_host" "$result"
else
    nix copy --to "ssh://$target_host" "$result"
fi

ssh -A "$target_host" sudo env NIXOS_INSTALL_BOOTLOADER=1 "$result/bin/switch-to-configuration" switch
ssh -A "$target_host" sudo nix-env --profile /nix/var/nix/profiles/system --set "$result"
