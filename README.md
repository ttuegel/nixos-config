# NixOS

## Passwords

Create hashed password files with `mkpasswd`:

```
mkpasswd -m sha-512 >secrets/users/<username>/hashed-password
```

## Install

1. Install a basic system following the instructions in the manual.
2. Clone this repository from GitHub over HTTPS.
3. Copy secrets over sneakernet.
4. Copy GnuPG configuration to get passwords from Gitolite.
5. Generate a binary cache key:

```
nix-store --generate-binary-cache-key $hostname-1 private-key public-key
sudo mv private-key /etc/nix/
cat public-key  # Add to programs/nix.nix
rm public-key
```
