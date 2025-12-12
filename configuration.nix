{ lib, ... }:
let
  # Define the current machine name here
  # Change this to match your machine's hostname or create a new machine config
  currentMachine = "solong";

  # Alternatively, you can detect the hostname automatically:
  # currentMachine = builtins.readFile /etc/hostname;
in
{
  imports = [
    # Import the machine-specific configuration
    # This file contains all the modules and profiles for this machine
    (./machines + "/${currentMachine}.nix")
  ];
}
