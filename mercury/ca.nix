{ secrets, ... }:

{
  security.pki.certificateFiles = [ "${secrets}/mercury/internal.mercury.com.ca.crt" ];
}
