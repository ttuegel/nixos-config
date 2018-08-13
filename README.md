# NixOS

## Passwords

Create hashed password files with `mkpasswd`:

```
mkpasswd -m sha-512 >config/users/<username>.hashedPassword
```
