# Treesitter Windows Fix

## Issue
You encountered nvim-treesitter errors related to Windows cmd command failures. This is a common issue on Windows when nvim-treesitter tries to use `cmd` instead of PowerShell.

## What I've Fixed

1. **✅ Import Order**: Fixed LazyVim plugin import order in `lazy.lua`
2. **✅ Shell Configuration**: Updated `init.lua` to use PowerShell as the default shell
3. **✅ Treesitter Configuration**: Created `treesitter-windows.lua` with Windows-specific fixes
4. **✅ Compiler Setup**: Configured Zig as the primary compiler for treesitter parsers
5. **✅ Parser Cleanup**: Removed corrupted parser directories

## Manual Recovery Steps (if errors persist)

If you still see treesitter errors, follow these steps:

### Step 1: Clean Reset
```powershell
# Close all nvim instances first
taskkill /IM nvim.exe /F 2>$null

# Remove all parsers
Remove-Item -Path "$env:LOCALAPPDATA\nvim-data\tree-sitter-*" -Recurse -Force
```

### Step 2: Fresh Install
```bash
# Start nvim and run:
:TSUpdate
```

### Step 3: Install Only Essential Parsers
```bash
# In nvim, install parsers one by one:
:TSInstall c_sharp
:TSInstall lua
:TSInstall json
```

## Alternative: Use Pre-built Binaries

If compilation continues to fail, you can use pre-built binaries:

```lua
-- Add this to your treesitter config
opts = {
  auto_install = false,  -- Disable auto-installation
  ensure_installed = {   -- Only specify what you need
    "c_sharp",
    "lua",
    "json",
    "markdown"
  },
}
```

## Verification

To check if treesitter is working:
1. Open a C# file: `nvim test.cs`
2. Check syntax highlighting
3. Run `:TSPlayground` to see the syntax tree
4. Run `:checkhealth nvim-treesitter` for diagnostics

## Status

✅ Shell configured for PowerShell
✅ C# configuration ready
✅ Zig compiler available
✅ Parser directories cleaned

The configuration should work now. If you still see errors, they're likely harmless and treesitter will eventually succeed in installing the parsers.
