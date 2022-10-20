{...}:

{
  services.tailscale = {
    enable = true;
    permitCertUid = "ttuegel@github";
  };

  # Warning: Strict reverse path filtering breaks Tailscale exit node use and
  # some subnet routing setups.
  networking.firewall.checkReversePath = "loose";
}
