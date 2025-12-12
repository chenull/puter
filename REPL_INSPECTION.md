# Inspecting NixOS Configuration in REPL

## Method 1: Simple Expression Evaluation

For basic inspection of the configuration structure:

```bash
nix repl
```

Then in the REPL:
```nix
:l <nixpkgs>
config = import ./configuration.nix {}
config
config.imports
```

## Method 2: Using NixOS Module System (Recommended)

To properly evaluate a NixOS configuration module, you need to use the module system:

```bash
nix repl '<nixpkgs>'
```

Then:
```nix
:l <nixpkgs/nixos>
config = import ./configuration.nix {}
# This will show the module structure
config
```

## Method 3: Evaluate with nix-instantiate

For a more complete evaluation (requires system configuration):

```bash
# Evaluate the configuration
nix-instantiate --eval -E '
  with import <nixpkgs/nixos> {
    configuration = import ./configuration.nix;
  };
  config
' -A imports

# Or to see the full evaluated config (warning: very large output)
nix-instantiate --eval --strict -E '
  with import <nixpkgs/nixos> {
    configuration = import ./configuration.nix;
  };
  config
'
```

## Method 4: Interactive REPL with Module System

```bash
nix repl '<nixpkgs/nixos>'
```

Then:
```nix
# Load your configuration
configModule = import ./configuration.nix

# You can inspect specific parts
configModule.imports
```

## Method 5: Using nixos-rebuild (Best for Full Evaluation)

```bash
# Dry run - shows what would be built
nixos-rebuild build --dry-run

# Or evaluate specific options
nix-instantiate '<nixpkgs/nixos>' -A config.system.build.toplevel --arg configuration ./configuration.nix
```

## Quick REPL Commands

Once in `nix repl`:
- `:?` - Show all commands
- `:l <path>` - Load a file or path
- `:t <expr>` - Show type of expression
- `:b <expr>` - Build expression
- `:q` - Quit

## Example: Inspecting Specific Options

```bash
nix repl '<nixpkgs/nixos>'
```

```nix
# Evaluate your config
eval = import <nixpkgs/nixos/lib> {
  modules = [ ./configuration.nix ];
}.evalModules

# Check specific options
eval.config.imports
eval.options.imports.description
```


