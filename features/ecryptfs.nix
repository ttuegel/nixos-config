{ config, pkgs, ... }:

{
  security.pam.enableEcryptfs = true;
}
