# LazyVim C# Configuration Guide

## What's Been Configured

Your LazyVim setup now includes comprehensive C# support with:

### 🔧 Language Server (OmniSharp)
- **OmniSharp LSP** with extended functionality for better Go-to-Definition
- **Enhanced IntelliSense** with Roslyn analyzers
- **Auto-import completion** and organize imports on format
- **Decompilation support** for viewing source code of dependencies

### 🎨 Formatting & Linting
- **CSharpier** formatter (v0.29.2) for consistent code formatting
- **EditorConfig** support for project-specific formatting rules
- **Format on save** automatically enabled for C# files
- **Conform.nvim** integration for seamless formatting

### 🧪 Testing & Debugging
- **neotest-dotnet** for running C# tests directly in Neovim
- **netcoredbg** debugger integration with nvim-dap
- **Debug configurations** for launching and attaching to processes

### 📁 File Management
- Proper file type detection for `.cs`, `.csx`, `.csproj`, `.sln` files
- 4-space indentation for C# files (following C# conventions)

## Key Features

### Language Server Features
- **Go to Definition**: Enhanced with `gd` keymap using omnisharp-extended
- **IntelliSense**: Full completion support with imports
- **Code Actions**: Refactoring and quick fixes
- **Hover Information**: Type information and documentation
- **Signature Help**: Parameter hints while typing

### Custom Keymaps
- `<leader>cu` - Remove unnecessary using statements
- `<leader>cU` - Add missing using statements
- `gd` - Enhanced go-to-definition with decompilation support

### Formatting
- **Automatic formatting** on save for C# files
- **CSharpier integration** with Conform.nvim
- **EditorConfig compliance** for consistent project formatting

### Testing & Debugging
- **Test Discovery**: Automatically finds and runs your C# tests
- **Debug Support**: Set breakpoints and debug C# applications
- **Process Attachment**: Attach debugger to running .NET processes

## File Structure

```
nvim/
├── lua/
│   └── plugins/
│       └── csharp.lua          # Main C# configuration
└── CSharp_Setup_Guide.md       # This guide

~/.editorconfig                 # Global EditorConfig for consistent formatting
```

## Installed Tools

- **dotnet-csharpier** (v0.29.2) - Code formatter
- **netcoredbg** - .NET Core debugger (will be installed via Mason)
- **omnisharp-extended-lsp.nvim** - Enhanced LSP functionality

## Usage Examples

### Starting a New C# Project
```bash
dotnet new console -n MyProject
cd MyProject
nvim Program.cs
```

### Formatting Code
- **Automatic**: Save the file (`:w`) - formatting happens automatically
- **Manual**: Use `:lua vim.lsp.buf.format()` or the format keymap

### Running Tests
- Use `:Neotest` commands to discover and run your tests
- Tests will appear in a tree view for easy navigation

### Debugging
1. Set breakpoints with your debugger keymaps
2. Use `:DapContinue` to start debugging
3. Choose "Launch file" and provide path to your compiled .dll

## Next Steps

1. **Restart Neovim** to ensure all plugins are loaded
2. **Open a C# file** to test the configuration
3. **Install additional tools** via `:Mason` if needed
4. **Customize keymaps** in your personal configuration as desired

## Troubleshooting

### If OmniSharp doesn't start:
- Ensure you have .NET SDK installed: `dotnet --version`
- Check LSP status: `:LspInfo`
- Restart LSP: `:LspRestart`

### If formatting doesn't work:
- Verify CSharpier: `dotnet-csharpier --version`
- Check formatter configuration: `:ConformInfo`

### If debugging fails:
- Ensure netcoredbg is installed: `:Mason`
- Check DAP configuration: `:DapShowLog`

### If treesitter errors occur:
- ✅ **FIXED**: Windows PowerShell configuration has been applied
- ✅ **FIXED**: Zig compiler is configured for parser compilation
- ✅ **FIXED**: Corrupted parsers have been cleaned up
- If errors persist, see `TREESITTER_FIX.md` for manual recovery steps

## Configuration Files Reference

- **Main config**: `lua/plugins/csharp.lua`
- **EditorConfig**: `~/.editorconfig`
- **Mason tools**: Managed automatically via Mason.nvim

Your C# development environment is now fully configured and ready to use!
