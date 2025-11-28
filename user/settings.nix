{ config, ... }: {
	users.users.${config.userName} = {
		# Short description (title) of the user account, typically the user's full name.
		description = "${config.userTitle}";

		# Extra groups to add the user to.
		extraGroups = [ "disk" "input" "plugdev" "storage" "wheel" ];

		# Set the user as a normal user.
		isNormalUser = true;
	};

	home-manager.users.${config.userName}.xdg.userDirs = {
		# Whether to manage `$XDG_CONFIG_HOME/user-dirs.dirs`.
		enable = true;

		# Whether to enable automatic creation of the XDG user directories.
		createDirectories = true;

		# Directories to configure.
		desktop     = "${config.users.users.${config.userName}.home}/Desktop";
		documents   = "${config.users.users.${config.userName}.home}/Documents";
		download    = "${config.users.users.${config.userName}.home}/Downloads";
		music       = "${config.users.users.${config.userName}.home}/Music";
		pictures    = "${config.users.users.${config.userName}.home}/Pictures";
		publicShare = "${config.users.users.${config.userName}.home}/Public";
		videos      = "${config.users.users.${config.userName}.home}/Movies";
	};
}
