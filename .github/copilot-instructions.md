# NixOS Configuration: AI Coding Agent Instructions

## Architecture Overview

This is a **modular NixOS system configuration** without flakes. The entry point is `configuration.nix`, which imports all modules explicitly. The system uses:
- **Niri Wayland compositor** as the window manager (scrollable-tiling)
- **Home Manager** fetched via tarball (release-25.05) for user-level configuration
- **Custom NixOS modules** in `custom-modules/` that extend standard options

## Critical Patterns

### 1. User Configuration Options (config.userName)
Three custom options are defined in `user/configUser.nix` and used throughout:
- `config.userName` (default: "ayik") - referenced in almost every module
- `config.userTitle` (default: "Sayid Munawar") 
- `config.userEmail`

**Always use `${config.userName}` instead of hardcoding usernames.**

Example from `desktop/fonts.nix`:
```nix
home-manager.users.${config.userName}.gtk.font = { ... };
```

### 2. Conditional Module Loading Pattern
Desktop-related modules only activate when Niri is enabled using `lib.mkIf`:
```nix
{ config, lib, pkgs, ... }: lib.mkIf config.programs.niri.enable {
  # Module content only evaluated if niri is enabled
}
```

See: `desktop/fonts.nix`, `desktop/icons.nix`, `desktop/fuzzel.nix`, `desktop/waybar.nix`

### 3. Custom Module System
Custom modules in `custom-modules/programs/niri/` extend the NixOS module system:
- Use `lib.mkEnableOption` for new options
- Follow pattern: `options.programs.niri.<feature>.enable`
- Implement `config` section with `lib.mkIf cfg.enable`

Example: `custom-modules/programs/niri/ozoneWayland.nix` adds `programs.niri.ozoneWayland.enable`

### 4. Home Manager Integration
Home Manager is system-wide (not per-user flake). Access via:
```nix
home-manager.users.${config.userName}.<option>
```

Check Home Manager state before using options:
```nix
foot = config.home-manager.users.${config.userName}.programs.foot.enable;
```

### 5. Systemd Tmpfiles for Config Linking
Configuration files in `desktop/files/` and `programs/files/` are linked via systemd tmpfiles:
```nix
systemd.user.tmpfiles.users.${config.userName}.rules = [
  "L %h/.config/niri/config.kdl - - - - /etc/nixos/desktop/files/niri.kdl"
];
```

## Development Workflow

### Building Configuration
```bash
sudo nixos-rebuild switch   # Apply changes
sudo nixos-rebuild test     # Test without making default boot entry
```

**Note:** No flakes in this project. No `--flake` flag needed (despite README showing it).

### Inspection & Debugging
Use `nix repl` for inspecting configuration. See `REPL_INSPECTION.md` for methods.
```bash
nix repl '<nixpkgs/nixos>'
# Load and inspect modules interactively
```

### State Management
- System state version: `25.05` (set in `system/nixos.nix`)
- Home Manager matches system state version automatically
- `/etc/nixos/` owned by user (via tmpfiles rule in `system/nixos.nix`)

## File Organization

### Module Categories
- **`system/`** - Core NixOS settings (boot, networking, packaging)
- **`desktop/`** - Niri compositor, Waybar, fonts, launchers
- **`programs/`** - Application configurations (terminal, editors, browsers)
- **`user/`** - User account setup, Home Manager integration
- **`hardware/devices/`** - Device-specific configs (hostname: solong)
- **`custom-modules/`** - New NixOS options extending upstream modules

### Configuration Files Pattern
Non-Nix config files live in `<module-type>/files/`:
- `desktop/files/niri.kdl` - Niri compositor config
- `desktop/files/waybar/` - Waybar JSON/CSS
- `programs/files/micro/` - Micro editor configs
- `programs/files/fastfetch.jsonc`

## Common Tasks

### Adding a New Program Module
1. Create `programs/<name>.nix`
2. Add import to `configuration.nix`
3. Use `config.userName` for user references
4. Put config files in `programs/files/<name>/`
5. Link with systemd tmpfiles if needed

### Adding Desktop Component (Niri-specific)
1. Create `desktop/<name>.nix` 
2. Wrap in `lib.mkIf config.programs.niri.enable`
3. Add import to `configuration.nix`
4. Configure via `home-manager.users.${config.userName}`

### Extending Niri Options
1. Create module in `custom-modules/programs/niri/<feature>.nix`
2. Define `options.programs.niri.<feature>.enable`
3. Add import to `custom-modules/all.nix`
4. Use in `desktop/niri.nix`: `programs.niri.<feature>.enable = true`

## Key Dependencies

- **No flakes** - Traditional channels/imports
- **Home Manager** - Fetched from GitHub tarball (release-25.05)
- **nvf** - Neovim framework (currently commented out in home-manager.nix)
- **Niri** - Main compositor (all desktop modules depend on it)
- **XWayland Satellite** - Custom XWayland support for Niri

## Gotchas

1. **Don't use flake commands** - This isn't a flake-based config despite README mentions
2. **Always check Niri enable state** - Desktop modules fail if Niri isn't enabled
3. **Home Manager state** - Check if a home-manager program is enabled before referencing: `config.home-manager.users.${config.userName}.programs.<name>.enable`
4. **System ownership** - `/etc/nixos/` is user-owned, not root-owned
5. **Font configuration** - Uses Nerd Fonts with specific naming: "Ubuntu Nerd Font", "UbuntuMono Nerd Font"
