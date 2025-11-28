{ config, pkgs, ... }:

{
  imports =
    [
      # Custom modules imported globally.
      ./custom-modules/all.nix

      ./hardware/devices/solong.nix
      ./hardware/generated/solong.nix # generated at install

      ./system/boot.nix               # Boot configuration.
      ./system/locale.nix             # Locale configuration (language, time, currency, measurement…)
      ./system/networking.nix         # Networking configuration.
      ./system/nixos.nix              # Nix and NixOS settings.
      ./system/packaging.nix          # Packaging configuration and supports (unfree software, Flatpak)
      ./system/ssh.nix                # OpenSSH configuration.
      ./system/terminal-colors.nix    # Terminal colorscheme.

      ./input/keyboard-layout.nix     # Keyboard layout configuration across all environments.
      ./input/utilities.nix           # Various input utilities.

      ./programs/foot.nix             # foot terminal emulator
      ./programs/git.nix              # Git and its settings.
      ./programs/micro.nix            # micro text editor.
      ./programs/shell-utilities.nix  # Various shell utilities (shell, calendar, calculator, git…)
      ./programs/sysinfo.nix          # System monitoring, benchmarking, and information gathering.

      ./desktop/dm.nix                # Display manager.
      ./desktop/fonts.nix             # Font configuration.
      ./desktop/niri.nix              # Niri Wayland compositor.
      ./desktop/waybar.nix            # Waybar bar on Niri session.

      ./user/configUser.nix           # Module where the user name and title are defined.
      ./user/home-manager.nix         # Support for Home Manager, managed system-wide.
      ./user/settings.nix             # User settings (extra groups, home directory, user type…)
    ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ayik = {
    isNormalUser = true;
    description = "Sayid Munawar";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim
  ];
}
