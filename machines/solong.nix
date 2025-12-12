{ ... }: {
  imports = [
    # Hardware configuration
    ../hardware/devices/solong.nix
    ../hardware/generated/solong.nix

    # Custom modules
    ../custom-modules/all.nix

    # Profiles - select which profiles this machine uses
    ../profiles/system/base.nix
    ../profiles/desktop/niri.nix
    ../profiles/programs/base.nix
    ../profiles/programs/development.nix
    ../profiles/programs/internet.nix
    ../profiles/input/base.nix
    ../profiles/gpu/nvidia.nix
    ../profiles/user/base.nix
  ];
}
