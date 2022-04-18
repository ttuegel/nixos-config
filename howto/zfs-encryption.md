# Encrypting ZFS datasets

Given:

- NixOS is installed on an unencrypted ZFS filesystem, and
- more than 50% free space in the ZFS storage pool;

then, this guide describes how to fully encrypt the filesystem with a single
reboot.

## Overview

If we were creating an encrypted storage pool from scratch, we would enable
encryption once and the settings would be inherited in every dataset:

```.sh
zpool create \
  -O encryption=aes-256-gcm \
  -O keylocation=prompt \
  -O keyformat=passphrase \
  ...
```

Note that the storage pool itself is not encrypted! This only sets the default
options for all the datasets in the pool. To avoid creating a new pool, we will
create a root dataset which is encrypted and migrate the existing unencrypted
datasets to encrypted datasets which inherit from the new root.

## Configuration

The storage pool is named `tank`, as is traditional. There are two heirarchies:

- `tank/safe`: datasets that are backed up
  - `tank/safe/root`: mounted at `/`
  - `tank/safe/home`: mounted at `/home`
- `tank/local`: datasets that are not backed up
  - `tank/local/nix`: the Nix store mounted at `/nix`

We will move all datasets under `tank/` to `tank/main/`. Adjust the following
instructions according to your own configuration.

Depending on your configuration, you may need to run `zfs` commands with `sudo`.
You can run the migration as an unprivileged user if you `allow` the correct
permissions:

```.sh
sudo zfs allow $username create,destroy,mount,snapshot,send,receive tank
```

(Replace `$username` with the actual username.)

## Creating the root dataset

The storage pool was not created with encryption enabled, so we create an
encrypted dataset to serve as the root of a new heirarchy:

```.sh
zfs create \
  -o mountpoint=legacy \
  -o compression=zstd \
  -o encryption=aes-256-gcm \
  -o keylocation=prompt \
  -o keyformat=passphrase \
  tank/main
```

Enter the new password when prompted.
Create new children in the encrypted root:

```.sh
zfs create tank/main/local
zfs create tank/main/safe
```

## Configure NixOS

Next we modify the NixOS configuration, changing any references to
`tank/foo/bar` to `tank/main/foo/bar`. It is very important to run
`nixos-rebuild` now, even though the encrypted datasets do not exist yet! In the
next step, we will create snapshots of the existing filesystems and the modified
configuration must be in the Nix store in those snapshots.

## Take snapshots

Make snapshots of the existing, unencrypted datasets:

```.sh
zfs snapshot tank/local/nix@(env TZ=UTC date '+%F_%T')
zfs snapshot tank/safe/home@(env TZ=UTC date '+%F_%T')
zfs snapshot tank/safe/root@(env TZ=UTC date '+%F_%T')
```

It is a good idea to close any applications you are not using to minimize
changes to the filesystems after the snapshots, but it is not required.

## Encrypt snapshots

Send the snapshots to new datasets under the encrypted root:

```.sh
zfs send tank/local/nix@... | zfs receive tank/main/local/nix
zfs send tank/safe/home@... | zfs receive tank/main/safe/home
zfs send tank/safe/root@... | zfs receive tank/main/safe/root
```

Verify that the new datasets are encrypted:

```.sh
zfs list -o name,encryption
```

## Reboot

Reboot. If all goes well, destroy the unencrypted datasets:

```.sh
zfs destroy -r tank/local
zfs destroy -r tank/safe
```
