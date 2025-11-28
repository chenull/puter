{ config, lib, pkgs, ... }: {
	environment = {
		systemPackages = with pkgs; [
			# Non-graphical programs.
			inetutils

			# Graphical programs.
		] ++ lib.optionals config.programs.niri.enable (with pkgs; [
			speedtest       # Graphical librespeed client.
			chromium        # chromium web browser
		]);

		# Default web browser to use.
		variables.BROWSER = lib.mkIf (
			config.programs.firefox.enable && config.programs.firefox.package == pkgs.librewolf
		) "librewolf";
	};

	# Whether to install the Firefox web browser.
	programs.firefox.enable = true;

	# Which package of Firefox (or fork of it) to install.
	programs.firefox.package = pkgs.librewolf;
}
