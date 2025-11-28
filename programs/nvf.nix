{ config, ... }:
let
  nvf = import (builtins.fetchTarball {
    url = "https://github.com/notashelf/nvf/archive/v0.8.tar.gz";
    sha256 = "sha256:0a0892vdxh0s0sih32ihqa6ppp77jzxn0l4padv3qlj2q7764ar7";
  });
in {
  imports = [
    # Import the NixOS module from your fetched input
    # nvf.homeManagerModules.nvf
  ];
  # programs.nvf.enable = true;
  # Once the module is imported, you may use `programs.nvf` as exposed by the
  # NixOS module.
  #home-manager.users.${config.userName}.programs.nvf = {
  #  enable = true;
  #};
}
