{ ... }: {
  imports = [
    # Hardware configuration (you would create this for your specific machine)
    # ../hardware/devices/example-minimal.nix
    # ../hardware/generated/example-minimal.nix

    # Custom modules
    ../custom-modules/all.nix

    # Profiles - minimal server setup without desktop environment
    ../profiles/system/base.nix
    ../profiles/programs/base.nix
    ../profiles/user/base.nix
  ];
}
