{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Use the proprietary NVIDIA drivers for 16XX and later GPUs.
  services.xserver.videoDrivers = [ "nvidia" ];
}
