{ config, lib, pkgs, ... }: {
	# Whether to allow installation of unfree (proprietary) software.
	nixpkgs.config.allowUnfree = true;

	# Whether to enable the Flatpak packaging system.
	# XDG portals need to be configured.
	services.flatpak.enable = false;
}
