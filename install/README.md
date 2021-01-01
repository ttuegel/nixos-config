# Installation

0.  Run `sudo su` to perform the following steps as user `root`.
1.  Follow the instructions in the manual to boot and partition the new system.
2.  Generate the hardware configuration.

```.sh
nixos-generate-config --root /mnt
```

3.  Clone the configuration.

```.sh
mkdir -p /mnt/etc; cd /mnt/etc
git clone https://github.com/ttuegel/nixos-config nixos
```

4.  Set a root password in the install environment.
    Activate the SSH daemon.

```.sh
passwd
systemctl start sshd
```

5.  Copy configuration secrets from the cache machine:

```.sh
rsync nixos-config/secrets/ root@nixos:/mnt/etc/nixos/secrets
```

6.  Install NixOS.

```.sh
./install-nixos.sh IP_ADDR -I nixpkgs=/mnt/etc/nixos/nixpkgs
```

7.  Authorize the new device in Zerotier.
8.  Set up desktop shortcuts and terminal colors.
9.  Copy GPG keys to new machine.

```.sh
# Export keys.
gpg --export-secret-keys --armor KEYID >secret.asc
# Move 'secret.asc' to the new machine.
# Import keys.
gpg --import secret.asc
# Trust keys.
gpg --edit-keys KEYID
# gpg> trust
# gpg> quit
```

10. Clone dotfiles with VCSH.

```.sh
vcsh clone gitolite@host:ttuegel/dotfiles
# Back up any conflicting files
vcsh dotfiles pull
```

11. Move the configuration repository at `/etc/nixos` to `$HOME/nixos-config`.
    Update remote URLs of configuration repository and push new host configuration to GitHub.
12. Clone password-store with pass.

```.sh
git clone gitolite@host:ttuegel/password-store .password-store
```

13. Set up Firefox Sync.
14. Get wallpapers.
15. Install user features like Emacs and Visual Studio Code.
