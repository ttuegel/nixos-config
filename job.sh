#!/usr/bin/env bash
set -ex

host="${1:?}"

nix-build \
    --option max-jobs 1 \
    -I nixos-config=$PWD/hosts/$host/configuration.nix \
    hosts/$host/nixpkgs/nixos \
    -A system
