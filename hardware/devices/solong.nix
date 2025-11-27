{ config, pkgs, ... }:

{
  # Select the Linux Kernel version to use.
  # https://wiki.nixos.org/wiki/Linux_kernel#List_available_kernels
  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "solong";
}
