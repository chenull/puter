# Modular NixOS Configuration

This configuration is organized into a modular structure that allows different machines to select which modules to apply.

## Directory Structure

```
.
├── configuration.nix          # Main entry point (selects which machine to use)
├── machines/                  # Machine-specific configurations
│   ├── solong.nix            # Your current machine
│   ├── example-minimal.nix   # Example minimal server setup
│   └── example-desktop.nix   # Example desktop without GPU
├── profiles/                  # Logical groupings of modules
│   ├── system/               # System-level configurations
│   ├── desktop/              # Desktop environment options
│   ├── programs/             # Program collections
│   ├── input/                # Input device configurations
│   ├── gpu/                  # GPU driver options
│   └── user/                 # User configurations
├── system/                    # Individual system modules
├── desktop/                   # Individual desktop modules
├── programs/                  # Individual program modules
├── input/                     # Individual input modules
├── gpu/                       # Individual GPU modules
├── user/                      # Individual user modules
└── hardware/                  # Hardware-specific configurations
    ├── devices/              # Per-machine device configs
    └── generated/            # NixOS hardware-scan generated configs
```

## How It Works

### 1. Main Configuration (`configuration.nix`)

The main configuration file selects which machine configuration to use:

```nix
{ lib, ... }:
let
  currentMachine = "solong";  # Change this to your machine name
in
{
  imports = [
    (./machines + "/${currentMachine}.nix")
  ];
}
```

### 2. Machine Configurations (`machines/`)

Each machine file defines which profiles to include:

```nix
# machines/solong.nix
{ ... }: {
  imports = [
    # Hardware
    ../hardware/devices/solong.nix
    ../hardware/generated/solong.nix

    # Profiles
    ../profiles/system/base.nix
    ../profiles/desktop/niri.nix
    ../profiles/programs/development.nix
    # ... etc
  ];
}
```

### 3. Profiles (`profiles/`)

Profiles are logical groupings of related modules:

- **system/base.nix** - Essential system modules (boot, networking, terminal, etc.)
- **desktop/niri.nix** - Niri compositor with waybar, fuzzel, etc.
- **desktop/base.nix** - Minimal desktop (just fonts and icons)
- **programs/base.nix** - Basic programs (git, shell utilities, sysinfo)
- **programs/development.nix** - Development tools (nvim, foot, micro, etc.)
- **programs/internet.nix** - Web browsers and internet tools
- **input/base.nix** - Keyboard layout and input utilities
- **gpu/nvidia.nix** - NVIDIA GPU drivers
- **user/base.nix** - User account configuration

## Adding a New Machine

1. Create hardware configuration files:
   ```bash
   # Generate hardware config on the target machine
   nixos-generate-config --show-hardware-config > hardware/generated/your-machine.nix
   ```

2. Create a device configuration:
   ```nix
   # hardware/devices/your-machine.nix
   { pkgs, ... }: {
     boot.kernelPackages = pkgs.linuxPackages_latest;
     networking.hostName = "your-machine";
   }
   ```

3. Create a machine configuration:
   ```nix
   # machines/your-machine.nix
   { ... }: {
     imports = [
       ../hardware/devices/your-machine.nix
       ../hardware/generated/your-machine.nix
       ../custom-modules/all.nix

       # Select which profiles you want:
       ../profiles/system/base.nix
       ../profiles/programs/base.nix
       # Add more profiles as needed
     ];
   }
   ```

4. Update `configuration.nix`:
   ```nix
   currentMachine = "your-machine";
   ```

5. Rebuild:
   ```bash
   sudo nixos-rebuild switch
   ```

## Example Configurations

### Minimal Server
```nix
# machines/server.nix
{ ... }: {
  imports = [
    ../hardware/devices/server.nix
    ../hardware/generated/server.nix
    ../custom-modules/all.nix
    ../profiles/system/base.nix
    ../profiles/programs/base.nix
    ../profiles/user/base.nix
  ];
}
```

### Desktop without Desktop Environment
```nix
# machines/minimal-desktop.nix
{ ... }: {
  imports = [
    ../hardware/devices/minimal-desktop.nix
    ../hardware/generated/minimal-desktop.nix
    ../custom-modules/all.nix
    ../profiles/system/base.nix
    ../profiles/programs/base.nix
    ../profiles/programs/development.nix
    ../profiles/user/base.nix
  ];
}
```

### Full Featured Workstation
```nix
# machines/workstation.nix
{ ... }: {
  imports = [
    ../hardware/devices/workstation.nix
    ../hardware/generated/workstation.nix
    ../custom-modules/all.nix
    ../profiles/system/base.nix
    ../profiles/desktop/niri.nix
    ../profiles/programs/base.nix
    ../profiles/programs/development.nix
    ../profiles/programs/internet.nix
    ../profiles/input/base.nix
    ../profiles/gpu/nvidia.nix
    ../profiles/user/base.nix
  ];
}
```

## Creating Custom Profiles

You can create custom profiles for specific use cases:

```nix
# profiles/programs/gaming.nix
{ ... }: {
  imports = [
    ../../programs/steam.nix
    ../../programs/gamemode.nix
  ];
}
```

Then include it in your machine configuration:
```nix
../profiles/programs/gaming.nix
```

## Tips

1. **Keep profiles focused**: Each profile should represent a logical group of related functionality
2. **Reuse profiles**: Create profiles that can be shared across multiple machines
3. **Machine-specific overrides**: Add machine-specific settings directly in the machine file
4. **Test incrementally**: When adding a new machine, start with minimal profiles and add more gradually

## Migration from Old Configuration

Your old configuration has been preserved in this modular structure:
- All original modules are still in their respective directories
- The `machines/solong.nix` file imports exactly the same modules as before
- You can switch back by reverting `configuration.nix` if needed

## Benefits

- **Clarity**: Easy to see which modules are enabled per machine
- **Flexibility**: Mix and match profiles for different machines
- **Maintainability**: Share common configurations across machines
- **Scalability**: Easy to add new machines or profiles
- **Organization**: Clear separation of concerns
