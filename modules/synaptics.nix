{ ... }:

{
  services.xserver.synaptics = {
    enable = true;
    twoFingerScroll = true;
    vertEdgeScroll = false;
    additionalOptions = ''
      Option "LockedDrags" "True"
      Option "LockedDragTimeout" "500"
    '';
  };
}
