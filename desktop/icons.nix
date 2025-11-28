{ config, lib, pkgs, ... }: lib.mkIf config.programs.niri.enable {
	home-manager.users = {
		# Icon and cursor theming for the user.
		${config.userName} = let
			cursorPackage = pkgs.bibata-cursors;
			cursorName = "Bibata-Modern-Ice";
			cursorSize = 24;
		in {
			home.pointerCursor = {
				# Whether to enable GTK configuration generation for `home.pointerCursor`.
				gtk.enable = true;

				# Package providing the cursor theme.
				package = cursorPackage;

				# The cursor name within the package.
				name = cursorName;

				# The cursor size.
				size = cursorSize;
			};

			gtk = {
				cursorTheme = {
					# Package providing the cursor theme.
					package = cursorPackage;

					# The name of the cursor theme within the package.
					name = cursorName;

					# The size of the cursor.
					size = cursorSize;
				};

				iconTheme = {
					# Package providing the icon theme.
					package = pkgs.flat-remix-icon-theme;

					# The name of the icon theme within the package.
					name = "Flat-Remix-Blue-Dark";
				};
			};
		};

		# Icon and cursor theming for the root user.
		root = let
			cursorPackage = pkgs.bibata-cursors;
			cursorName = "Bibata-Modern-Amber";
			cursorSize = 24;
		in {
			home.pointerCursor = {
				# Whether to enable GTK configuration generation for `home.pointerCursor`.
				gtk.enable = true;

				# Package providing the cursor theme.
				package = cursorPackage;

				# The cursor name within the package.
				name = cursorName;

				# The cursor size.
				size = cursorSize;
			};

			gtk = {
				cursorTheme = {
					# Package providing the cursor theme.
					package = cursorPackage;

					# The name of the cursor theme within the package.
					name = cursorName;

					# The size of the cursor.
					size = cursorSize;
				};

				iconTheme = {
					# Package providing the icon theme.
					package = pkgs.flat-remix-icon-theme;

					# The name of the icon theme within the package.
					name = "Flat-Remix-Red-Dark";
				};
			};
		};
	};
}
