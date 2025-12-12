{ ... }: {
  imports = [
    # Hardware configuration (you would create this for your specific machine)
    # ../hardware/devices/example-desktop.nix
    # ../hardware/generated/example-desktop.nix

    # Custom modules
    ../custom-modules/all.nix

    # Profiles - full desktop setup without GPU drivers
    ../profiles/system/base.nix
    ../profiles/desktop/niri.nix
    ../profiles/programs/base.nix
    ../profiles/programs/development.nix
    ../profiles/programs/internet.nix
    ../profiles/input/base.nix
    ../profiles/user/base.nix
  ];
}
