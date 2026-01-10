{ pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    plugins = with pkgs.vimPlugins; [
      # Essentials
      telescope-nvim
      telescope-fzf-native-nvim
      nvim-treesitter.withAllGrammars
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      
      # QoL
      toggleterm-nvim
      vim-tmux-navigator
      comment-nvim
      nvim-autopairs
      gitsigns-nvim
      
      # UI
      tokyonight-nvim
      lualine-nvim
      nvim-web-devicons
      bufferline-nvim
      
      # Which-key (manual trigger only)
      which-key-nvim
      
      # Plenary (telescope dependency)
      plenary-nvim
    ];
    
    extraLuaConfig = ''
      -- Leader key
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "
      
      -- Basic settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.mouse = "a"
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.hlsearch = false
      vim.opt.wrap = false
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
      vim.opt.scrolloff = 8
      vim.opt.signcolumn = "yes"
      vim.opt.updatetime = 250
      vim.opt.termguicolors = true
      
      -- Colorscheme
      require("tokyonight").setup({
        style = "night",
        transparent = false,
      })
      vim.cmd[[colorscheme tokyonight]]
      
      -- Treesitter
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
      })
      
      -- LSP Setup
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      -- Python
      lspconfig.pyright.setup({ capabilities = capabilities })
      
      -- C++
      lspconfig.clangd.setup({ capabilities = capabilities })
      
      -- Rust (if you start using it)
      lspconfig.rust_analyzer.setup({ capabilities = capabilities })
      
      -- LSP Keybinds
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
      
      -- Completion
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
      
      -- Autopairs
      require("nvim-autopairs").setup({})
      
      -- Comment
      require("Comment").setup()
      
      -- Gitsigns
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
      
      -- Telescope
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/", "__pycache__" },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
          },
        },
      })
      require("telescope").load_extension("fzf")
      
      -- Telescope keybinds
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Recent files" })
      
      -- Toggleterm
      require("toggleterm").setup({
        open_mapping = [[<C-\>]],
        direction = "float",
        float_opts = {
          border = "curved",
        },
      })
      
      -- Lualine
      require("lualine").setup({
        options = {
          theme = "tokyonight",
          component_separators = "|",
          section_separators = "",
        },
      })
      
      -- Bufferline
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          separator_style = "thin",
          offsets = {
            { filetype = "NvimTree", text = "File Explorer", text_align = "center" },
          },
        },
      })
      
      -- Which-key (manual trigger only with <leader>?)
      require("which-key").setup({
        triggers = {},  -- Disable auto-trigger
      })
      vim.keymap.set("n", "<leader>?", "<cmd>WhichKey<cr>", { desc = "Show keybinds" })
      
      -- General keybinds
      vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
      vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
      vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
      
      -- Buffer navigation
      vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
      vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
      vim.keymap.set("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close buffer" })
    '';
  };
  
  home.packages = with pkgs; [
    # LSP servers
    pyright
    clang-tools  # includes clangd
    rust-analyzer
    
    # Tools for telescope
    ripgrep
    fd
  ];
}
