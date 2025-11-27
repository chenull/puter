{ config, pkgs, ... }: {
	programs.git = {
		# Whether to enable git, a distributed version control system.
		enable = true;
	};
}
