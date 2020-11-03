# Zeus

## Initialization

### ZFS

Create the ZFS pool and filesystems:

```.sh
zpool create -O xattr=sa -o ashift=12 -o autoexpand=on tank \
    mirror \
        /dev/disk/by-id/ata-WDC_WD40EFRX-68N32N0_WD-WCC7K0TL8ZXR \
        /dev/disk/by-id/ata-WDC_WD40EFRX-68N32N0_WD-WCC7K3FFHYLD

zfs create -o mountpoint=legacy -o compression=lz4 tank/postgresql

zfs create -o mountpoint=legacy -o compression=lz4 tank/nextcloud
```

### PostgreSQL

Migrate PostgreSQL to ZFS:

```.sh
# Stop PostgreSQL
systemctl stop postgresql
# Migrate data
mkdir -p /mnt
mount -t zfs tank/postgresql /mnt
rsync -a /var/lib/postgresql/ /mnt
umount /mnt
# Replace data directory with mountpoint
rm -fr /var/lib/postgresql
mkdir /var/lib/postgresql
chown postgres:postgres /var/lib/postgresql
chmod o-rwx /var/lib/postgresql
mount -t zfs tank/postgresql /var/lib/postgresql
# Restart PostgreSQL
systemctl start postgresql
```

### Wireguard

Create a key pair for Wireguard:

```.sh
mkdir -p /var/lib/wireguard
wg genkey >/var/lib/wireguard/private.key
chmod go-r /var/lib/wireguard/private.key
wg pubkey </var/lib/wireguard/private.key >/var/lib/wireguard/public.key
```

### Nextcloud

Migrate Nextcloud to ZFS:

```.sh
# Stop nginx
systemctl stop nginx
# Migrate data
mkdir -p /mnt
mount -t zfs tank/nextcloud /mnt
rsync -a /var/lib/nextcloud/ /mnt
umount /mnt
# Replace data directory with mountpoint
rm -fr /var/lib/nextcloud
mkdir /var/lib/nextcloud
chown nextcloud:nextcloud /var/lib/nextcloud
mount -t zfs tank/nextcloud /var/lib/nextcloud
# Restart nginx
systemctl start nginx
```
