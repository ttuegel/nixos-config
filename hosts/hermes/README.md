# Encrypting ZFS datasets

The storage pool was not created with encryption enabled, so we create an
encrypted dataset to serve as the root of a new heirarchy:

```.sh
sudo zfs create \
  -o mountpoint=legacy \
  -o compression=zstd \
  -o encryption=aes-256-gcm \
  -o keylocation=prompt \
  -o keyformat=passphrase \
  tank/root
```

Enter the new password when prompted.
Create new children in the encrypted root:

```.sh
sudo zfs create tank/root/local
sudo zfs create tank/root/safe
```

Note that we are not prompted for a new password because all encryption settings
and keys are inherited.

Now rebuild the configuration, changing any references to `tank/foo/bar` to
`tank/root/foo/bar`. It is very important to run `nixos-rebuild` before creating
the encrypted copies of the datasets, so that the new configuration exists on
the encrypted side!

Make snapshots of the existing, unencrypted datasets:

```.sh
zfs snapshot tank/local/nix@(env TZ=UTC date '+%F_%T')
zfs snapshot tank/safe/home@(env TZ=UTC date '+%F_%T')
zfs snapshot tank/safe/root@(env TZ=UTC date '+%F_%T')
```

Send the snapshots to new datasets under the encrypted root:

```.sh
zfs send tank/local/nix@... | zfs receive tank/root/local/nix
zfs send tank/safe/home@... | zfs receive tank/root/safe/home
zfs send tank/safe/root@... | zfs receive tank/root/safe/root
```

Verify that the new datasets are encrypted:

```.sh
sudo zfs list -o name,encryption,keystatus,keyformat,keylocation,encryptionroot,mountpoint,compression
```

Reboot. If all goes well, destroy the unencrypted datasets:

```.sh
sudo zfs destroy -r tank/local
sudo zfs destroy -r tank/safe
```
