# maia

## Partitioning

Back up the disk before partitioning anything.

``` .sh
DISK=/dev/disk/by-id/nvme-PC711_NVMe_SK_hynix_1TB__ASA6N74641090725J
parted $DISK -- mklabel gpt  # create new partition table
parted $DISK -- mkpart primary 512MiB 100%  # create primary partition
parted $DISK -- mkpart ESP fat32 1MiB 512MiB  # create ESP (EFI boot) partition
parted $DISK -- set 2 esp on
```

Set up ESP file system.

``` .sh
mkfs.vfat $DISK-part2
```

Set up ZFS file systems.

``` .sh
zpool create -O mountpoint=none -O compression=lz4 -O xattr=sa -O acltype=posixacl -o ashift=12 rpool $DISK-part1
zfs create -o mountpoint=legacy rpool/local
zfs create -o mountpoint=legacy rpool/local/nix
zfs create -o mountpoint=legacy rpool/safe
zfs create -o mountpoint=legacy rpool/safe/root
zfs create -o mountpoint=legacy rpool/safe/home
```

Set up mount points before running the installer.

``` .sh
mount -t zfs rpool/safe/root /mnt
mkdir /mnt/home
mount -t zfs rpool/safe/home /mnt/home
mkdir /mnt/nix
mount -t zfs rpool/local/nix /mnt/nix
mkdir /mnt/boot
mount $DISK-part2 /mnt/boot
```

## Install

Configure the installer.

``` .sh
nixos-generate-config --root /mnt
```

Clone this repository.

``` .sh
nix-env -iA nixos.git
cd /mnt/etc
mv nixos nixos.bak
git clone git@github.com:ttuegel/nixos-config.git nixos
cd nixos
mkdir -p hosts/maia
mv ../nixos.bak/configuration.nix hosts/maia
mv ../nixos.bak/hardware-configuration.nix hosts/maia/hardware.nix
ln -s hosts/maia/configuration.nix configuration.nix
```

Edit `configuration.nix` as needed. Run the installer.

``` .sh
nixos-install
```

For convenience, copy over keys. From an established box,

``` .sh
gpg --armor --export KEYID >public.key
gpg --armor --export-secret-keys KEYID >secret.key
rsync public.key nixos@ADDR:/mnt/home/ttuegel/
rsync secret.key nixos@ADDR:/mnt/home/ttuegel/
rm public.key secret.key
```

## Reboot

Unmount drives and export ZFS pools.

``` .sh
umount /mnt/{boot,home,nix}
umount /mnt
zpool export rpool
```

Power off.

``` .sh
sudo systemctl poweroff
```

Remove boot media and restart.

## Configure

After rebooting, approve the new machine in [ZeroTier](https://my.zerotier.com).

Import keys.

``` .sh
gpg --import private.key
gpg --import secret.key
rm private.key secret.key
gpg --edit-key KEYID
# change the 'trust' level to 'ultimate'
```

Enable SSH in `gpg-agent`.

```
# ~/.gnupg/gpg-agent.conf
enable-ssh-support
pinentry-program /run/current-system/sw/bin/pinentry-qt
```

Log in again for changes to take effect.

``` .sh
gpg --list-keys --with-keygrip
echo KEYGRIP >>~/.gnupg/sshcontrol
```

Clone configuration.

``` .sh
vcsh clone gitolite@zeus:ttuegel/dotfiles
rm ~/.gnupg/gpg-agent.conf ~/.gnupg/sshcontrol
vcsh dotfiles checkout master
```
