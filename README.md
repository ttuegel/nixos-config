# NixOS

## Passwords

Create hashed password files with `mkpasswd`:

```
mkpasswd -m sha-512 >secrets/users/<username>/hashed-password
```
