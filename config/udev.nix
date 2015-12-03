{ ... }:

{
  services.udev.extraRules = ''
    # set deadline scheduler for non-rotating disks
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="deadline"
  '';
}
