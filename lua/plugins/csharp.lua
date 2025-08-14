-- C# Development Setup with OmniSharp
-- Note: The OmniSharp extra is imported in lazy.lua for proper loading order
return {
  -- Additional C# treesitter configuration (already handled by the extra but shown for reference)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
        vim.list_extend(opts.ensure_installed, { "c_sharp" })
    end,
  },

  -- Mason configuration for C# tools (enhanced from the extra)
  {
    "mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "csharpier", -- Formatter
        "netcoredbg", -- Debugger
      })
    end,
  },

  -- Enhanced OmniSharp LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
              omnisharp = {
        -- Enhanced OmniSharp settings
        enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
          analyze_open_documents_only = false,
          enable_decompilation_support = true,
          enable_package_restore = true,
          -- Add more comprehensive settings
          settings = {
            FormattingOptions = {
              EnableEditorConfigSupport = true,
              OrganizeImports = true,
            },
            MsBuild = {
              LoadProjectsOnDemand = false,
            },
            RoslynExtensionsOptions = {
              EnableAnalyzersSupport = true,
              EnableImportCompletion = true,
              AnalyzeOpenDocumentsOnly = false,
            },
          },
          -- Custom keymaps for C# specific actions
          keys = {
            {
              "gd",
              function()
                if require("lazyvim.util").has("telescope.nvim") then
                  require("omnisharp_extended").telescope_lsp_definitions()
                else
                  require("omnisharp_extended").lsp_definitions()
                end
              end,
              desc = "Goto Definition",
            },
            {
              "<leader>cu",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.removeUnnecessaryImports" },
                  },
                })
              end,
              desc = "Remove Unnecessary Usings",
            },
            {
              "<leader>cU",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.addMissingImports" },
                  },
                })
              end,
              desc = "Add Missing Usings",
            },
          },
        },
      },
    },
  },

  -- CSharpier formatter configuration (for none-ls if you're using it)
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.csharpier)
    end,
  },

  -- Conform.nvim formatter configuration (recommended approach)
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
      formatters = {
        csharpier = {
          command = "dotnet-csharpier",
          args = { "--write-stdout" },
          stdin = true,
        },
      },
    },
  },

  -- Enhanced neotest configuration for C# testing
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "Issafalcon/neotest-dotnet",
    },
    opts = {
      adapters = {
        ["neotest-dotnet"] = {
          dap = {
            args = { justMyCode = false },
            console = "integratedTerminal",
          },
          discovery_root = "project",
        },
      },
    },
  },

  -- DAP (Debug Adapter Protocol) configuration for .NET debugging
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")

      -- NetCoreDbg adapter configuration
      if not dap.adapters["netcoredbg"] then
        dap.adapters["netcoredbg"] = {
          type = "executable",
          command = vim.fn.exepath("netcoredbg"),
          args = { "--interpreter=vscode" },
          options = {
            detached = false,
          },
        }
      end

      -- Configuration for C#, F#, and VB.NET
      for _, lang in ipairs({ "cs", "fsharp", "vb" }) do
        if not dap.configurations[lang] then
          dap.configurations[lang] = {
            {
              type = "netcoredbg",
              name = "Launch file",
              request = "launch",
              program = function()
                return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
              end,
              cwd = "${workspaceFolder}",
              stopAtEntry = false,
              console = "integratedTerminal",
            },
            {
              type = "netcoredbg",
              name = "Attach to process",
              request = "attach",
              processId = function()
                return require("dap.utils").pick_process()
              end,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end
    end,
  },

  -- Additional file type associations and settings
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Ensure C# files are properly detected
      vim.filetype.add({
        extension = {
          cs = "cs",
          csx = "cs",
          csproj = "xml",
          sln = "solution",
          props = "xml",
          targets = "xml",
        },
      })
    end,
  },

  -- Auto commands for C# specific settings
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "cs" },
        callback = function()
          -- Set C# specific options
          vim.opt_local.tabstop = 4
          vim.opt_local.shiftwidth = 4
          vim.opt_local.expandtab = true

          -- Enable format on save for C# files
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = 0,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end,
      })
    end,
  },
}
