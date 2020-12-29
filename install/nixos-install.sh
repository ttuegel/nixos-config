#!/bin/sh

host=$1; shift
nixos-install \
    --option binary-caches "$host" \
    --option trusted-public-keys 'zeus-1:hpocFIqCGUxWFSSlvq5V0ImyCQhl+LcnCB21C7bhqjs=' \
    "$@"