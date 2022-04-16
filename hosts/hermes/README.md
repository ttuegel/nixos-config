# Encrypting ZFS datasets

The storage pool was not created with encryption enabled, so we create an
encrypted dataset to serve as the root of a new heirarchy:

```.hs
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

```.hs
sudo zfs create tank/root/local
sudo zfs create tank/root/safe
```

Note that we are not prompted for a new password because all encryption settings
and keys are inherited.

Make snapshots of the existing, unencrypted datasets:

```.hs
zfs snapshot tank/local/nix@(env TZ=UTC date '+%F_%T')
zfs snapshot tank/safe/home@(env TZ=UTC date '+%F_%T')
zfs snapshot tank/safe/root@(env TZ=UTC date '+%F_%T')
```

Send the snapshots to new datasets under the encrypted root:

```.hs
zfs send tank/local/nix@... | zfs receive tank/root/local/nix
zfs send tank/safe/home@... | zfs receive tank/root/safe/home
zfs send tank/safe/root@... | zfs receive tank/root/safe/root
```

Verify that the new datasets are encrypted:

```.hs
sudo zfs list -o name,encryption,keystatus,keyformat,keylocation,encryptionroot,mountpoint,compression
```
