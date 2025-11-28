{ config, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
    sha256 = "sha256:07pk5m6mxi666dclaxdwf7xrinifv01vvgxn49bjr8rsbh31syaq";
  };
  nvf = import (builtins.fetchTarball {
    url = "https://github.com/notashelf/nvf/archive/v0.8.tar.gz";
	sha256 = "sha256:0a0892vdxh0s0sih32ihqa6ppp77jzxn0l4padv3qlj2q7764ar7";
  });
in {
	# Import the Home Manager module.
	imports = [
	  (import "${home-manager}/nixos")
	  # nvf.homeManagerModules.nvf
	];

	# Backup file extension to use when backing up files replaced by Home Manager.
	home-manager.backupFileExtension = "HM-Backup";

	# State version of Home Manager.
	# Here, it is assumed that Home Manager was installed with the same version of NixOS that was installed.
	home-manager.users.${config.userName}.home.stateVersion = "${config.system.stateVersion}";
	home-manager.users.root.home.stateVersion = "${config.system.stateVersion}";
}
