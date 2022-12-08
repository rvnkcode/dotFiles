-- ============================= declair =============================
local cmd = vim.cmd
local g = vim.g
local opt = vim.opt
local keymap = vim.keymap

g.mapleader = " "

-- ============================= basic settings =============================
cmd("language en_US")
cmd("filetype plugin on")
opt.autowrite = true
opt.encoding = "utf-8"
opt.mouse = "a"
opt.title = true
opt.splitright = true
opt.splitbelow = true
-- set diffopt+=vertical
opt.ignorecase = true
opt.smartcase = true
opt.cindent = true
opt.softtabstop = 4
opt.shiftwidth = 4
-- customize indentation JS, TS, html, Markdown, CSS, xml
cmd([[autocmd Filetype javascript setlocal shiftwidth=2 softtabstop=2]])
cmd([[autocmd Filetype typescript setlocal shiftwidth=2 softtabstop=2]])
cmd([[autocmd Filetype html setlocal shiftwidth=2 softtabstop=2]])
cmd([[autocmd Filetype markdown setlocal shiftwidth=2 softtabstop=2]])
cmd([[autocmd Filetype typescriptreact setlocal shiftwidth=2 softtabstop=2]])
cmd([[autocmd Filetype javascriptreact setlocal shiftwidth=2 softtabstop=2]])
cmd([[autocmd Filetype css setlocal shiftwidth=2 softtabstop=2]])
cmd([[autocmd FileType xml setlocal shiftwidth=2 softtabstop=2]])
cmd([[autocmd FileType cpp setlocal shiftwidth=2 softtabstop=2]])
opt.expandtab = true
opt.undofile = true
opt.langmap = {
    "ㅁa",
    "ㅠb",
    "ㅊc",
    "ㅇd",
    "ㄷe",
    "ㄹf",
    "ㅎg",
    "ㅗh",
    "ㅑi",
    "ㅓj",
    "ㅏk",
    "ㅣl",
    "ㅡm",
    "ㅜn",
    "ㅐo",
    "ㅔp",
    "ㅂq",
    "ㄱr",
    "ㄴs",
    "ㅅt",
    "ㅕu",
    "ㅍv",
    "ㅈw",
    "ㅌx",
    "ㅛy",
    "ㅋz",
}
-- opt.foldmethod = "indent"
-- cmd([[au BufRead * normal zR]]) -- 처음 파일을 열면 자동으로 folding 되어있는데 이걸 막아줌

-- vim에서 복사한 내용이 클립보드에 저장됨!
opt.clipboard = "unnamed" -- OS마다 설정이 다르기 때문에 확인 필요. 이건 mac 기준

-- set wildmode=list:longest	                        -- make wildmenu behave like similar to bash completion
-- set wildignore=*.docx,*.jpg,*.png,*.gif,*.pyc,*.exe,*.flv,*.img,*.xlsx,*.zip

-- 마지막 편집 위치 복원 기능
cmd([[au BufReadPost *
\ if line("'\'") > 0 && line("'\'") <= line("$") |
\	exe "norm g`\"" |
\endif]])

-- 기본적인 vim 표시 기능들 관련
opt.number = true
opt.relativenumber = true
opt.cursorline = true
-- opt.cursorcolumn = true
opt.showtabline = 2
opt.showmatch = true
opt.wrap = false

-- ============================= plugins =============================
cmd([[lua require('plugins')]])

-- ============================= colorschemes =============================
-- opt.background = 'light'
local c = require("vscode.colors")
require("vscode").setup({
    -- Enable transparent background
    transparent = true,

    -- Enable italic comment
    italic_comments = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,

    -- Override colors (see ./lua/vscode/colors.lua)
    color_overrides = {
        vscLineNumber = "#FFFFFF",
    },

    -- Override highlight groups (see ./lua/vscode/theme.lua)
    group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
    },
})

-- ============================= autocompletion =============================
opt.completeopt = { "menu", "menuone", "preview", "noinsert", "noselect" }
local cmp = require("cmp")

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-c>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- For luasnip users.
        -- { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
        { name = "nvim_lsp_document_symbol" },
    }, {
        { name = "buffer" },
        { name = "nvim_lsp_signature_help" },
    }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

-- ============================= LSP configuration =============================
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
require("lspconfig").cssls.setup({
    capabilities = capabilities,
})
require("lspconfig").html.setup({
    capabilities = capabilities,
})
require("lspconfig").sumneko_lua.setup({
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})
require("lspconfig").eslint.setup({})
require("lspconfig").jsonls.setup({})
require("lspconfig").tsserver.setup({})
require("lspconfig").clangd.setup({})

-- ============================= telescope =============================
local telescope_actions = require("telescope.actions.set")

local fixfolds = {
    hidden = true,
    attach_mappings = function(_)
        telescope_actions.select:enhance({
            post = function()
                cmd(":normal! zx")
            end,
        })
        return true
    end,
}

require("telescope").setup({
    pickers = {
        buffers = fixfolds,
        find_files = fixfolds,
        git_files = fixfolds,
        grep_string = fixfolds,
        live_grep = fixfolds,
        oldfiles = fixfolds,
    },
})

require("telescope").setup({
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
        },
    },
})
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")
require("telescope").load_extension("dap")

-- ============================= nvim.tree =============================
-- disable netrw at the very start of your init.lua (strongly advised)
g.loaded = 1
g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    keymap.set("n", "\\", ":NvimTreeToggle<CR>"),
})

-- ============================= masson =============================
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})
require("mason-nvim-dap").setup({ automatic_setup = true })
require("mason-null-ls").setup({ automatic_setup = true })

-- ============================= lualine =============================
local function maximize_status()
    return vim.t.maximized and "   " or ""
end

require("lualine").setup({
    options = {
        theme = "powerline",
    },
    sections = {
        lualine_c = { maximize_status, "filename" },
    },
})

-- ============================= tabline =============================
-- opt.termguicolors = true
require("bufferline").setup({
    options = {
        numbers = "buffer_id",
    },
})

-- ============================= indent-blankline =============================
opt.list = true
opt.listchars:append("eol:↲")

require("indent_blankline").setup({
    show_current_context = true,
    show_current_context_start = true,
    show_end_of_line = true,
})

-- ============================= gitSigns =============================
require("gitsigns").setup({
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(function()
                gs.next_hunk()
            end)
            return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return "<Ignore>"
        end, { expr = true })

        -- Actions
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
        map("n", "<leader>hS", gs.stage_buffer)
        map("n", "<leader>hu", gs.undo_stage_hunk)
        map("n", "<leader>hR", gs.reset_buffer)
        map("n", "<leader>hp", gs.preview_hunk)
        map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
        end)
        map("n", "<leader>tb", gs.toggle_current_line_blame)
        map("n", "<leader>hd", gs.diffthis)
        map("n", "<leader>hD", function()
            gs.diffthis("~")
        end)
        map("n", "<leader>td", gs.toggle_deleted)

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end,
})

-- ============================= bookmarks =============================
require("bookmarks").setup({
    keymap = {
        toggle = "<tab><tab>", -- toggle bookmarks
        add = "<leader>B", -- add bookmarks
        jump = "<CR>", -- jump from bookmarks
        delete = "dd", -- delete bookmarks
        order = "<leader><leader>", -- order bookmarks by frequency or updated_time
    },
    width = 0.8, -- bookmarks window width:  (0, 1]
    height = 0.6, -- bookmarks window height: (0, 1]
    preview_ratio = 0.4, -- bookmarks preview window ratio (0, 1]
    -- if true, preview buf will add file ext, preview window may be highlighed(treesitter), but may be slower.
    preview_ext_enable = false,
    -- if true, when saving the current file, if the bookmark line number of the current file changes, try to fix it.
    fix_enable = false,
    hl_cursorline = "guibg=Gray guifg=White", -- hl bookmarsk window cursorline.
})

-- ============================= keymaps =============================
require("which-key").setup({})
require("legendary").setup({
    keymaps = {
        { '<leader>v', ':e $MYVIMRC<CR>', description = 'edit init.lua' },
        { '<leader>F', vim.lsp.buf.format, description = 'Format buffer with LSP' },
        { "<leader>rn", vim.lsp.buf.rename, description = "rename variable etc..." },
        { "<leader>q", vim.diagnostic.setloclist, description = "see list of diagnostics result" },
        { "[d", vim.diagnostic.goto_prev, description = "move to former diagnostic" },
        { "]d", vim.diagnostic.goto_next, description = "move to next diagnostic" },
        { "K", vim.lsp.buf.hover, description = "hover" },
        { "gD", vim.lsp.buf.declaration,
            description = "Jumps to the declaration of the symbol under the cursor. Many servers do not implement this method. Generally, see vim.lsp.buf.definition() instead." },
        { "gd", vim.lsp.buf.definition, description = "Jumps to the definition of the symbol under the cursor." },
        { "gr", vim.lsp.buf.references, description = "Lists all the references" },
        { "gi", vim.lsp.buf.implementation, description = "lsp implementation" },
        { "<C-k>", vim.lsp.buf.signature_help, description = "lsp signature help" },
        { "<leader>D", vim.lsp.buf.type_definition, description = "lsp type definition" },
        { "<leader>ca", vim.lsp.buf.code_action, description = "lsp code action" },
        { "<leader>T", ":ToggleTerm<CR>", description = "toggle terminal" },
        { "<leader>ts", ":ToggleTerm size=80 direction=vertical<CR>", description = " toggle terminal vertical" },
        { "<leader>th", ":ToggleTerm size=20 direction=horizontal<CR>", description = "toggle terminal horizontal" },
        { "<leader>tf", ":ToggleTerm direction=float<CR>", description = "toggle terminal float" },
        { "<leader>t", "<C-\\><C-n>:ToggleTerm<CR>", mode = "t", description = "toggle terminal in terminal mode" },
        { "<Esc>", "<C-\\><C-n>", mode = "t", description = "escape terminal in terminal mode" },
        { "<leader>fd", ":Telescope dap list_breakpoints<CR>", description = "telescope debug point list" },
        { '<leader>le', ':Legendary<CR>', description = 'launch legendary plugin' },
        { "<leader>ff", ":Telescope find_files<CR>", description = "Telescope find files" },
        { "<leader>fb", ":Telescope buffers<CR>", description = "Telescope find buffers" },
        { "<leader>fg", ":Telescope live_grep<CR>", description = "Telescope live grep" },
        { "<leader>fr", ":Telescope resume<CR>", description = "Telescope resume" },
        { "<F5>", ":lua require'dap'.continue()<CR>", description = "DAP continue" },
        { "<F8>", ":DAPTerminate<CR>", description = "DAP terminate" },
        { "<F9>", ":lua require'dap'.toggle_breakpoint()<CR>", description = "toggle breakpoint" },
        { "<F10>", ":lua require'dap'.step_over()<CR>", description = "step over" },
        { "<F11>", ":lua require'dap'.step_into()<CR>", description = "step into" },
        { "<F12>", ":lua require'dap'.step_out()<CR>", description = "step out" },
        { "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
            description = "breakpoint condition" },
        { "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
            description = "log breakpoint message" },
        { "<leader>dr", ":lua require'dap'.repl.open()<CR>", description = "repl open" },
        { "<leader>dl", ":lua require'dap'.run_last()<CR>", description = "run last" },
        { "<leader>z", ":lua require('maximize').toggle()<CR>", description = "window maximize toggle" },
    }
})

-- ============================= debugger =============================
require("nvim-dap-virtual-text").setup({})
g.dap_virtual_text = true

require("dapui").setup({})
local dap, dapui = require("dap"), require("dapui")
-- local dap = require("dap")
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

require("dap-vscode-js").setup({
    -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
    -- which adapters to register in nvim-dap
    adapters = { "pwa-node" }, --, 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})
for _, language in ipairs({ "typescript", "javascript" }) do
    require("dap").configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
        --[[ {
    type = "pwa-node",
    request = "attach",
    name = "Attach",
    processId = require'dap.utils'.pick_process,
    cwd = "${workspaceFolder}",
  } ]]
    }
end

dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        -- CHANGE THIS to your path!
        command = '/Users/ksy/.local/share/nvim/mason/packages/codelldb/codelldb',
        args = { "--port", "${port}" },
    }
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        terminal = 'integrated',
    },
}

dap.defaults.fallback.focus_terminal = true

-- ============================= others =============================
require("toggleterm").setup({})
require("marks").setup({})
require("maximize").setup({})
require("Comment").setup({})
require("null-ls").setup({})
require("nvim-autopairs").setup({})
require("nvim-surround").setup({})
require("clangd_extensions").setup({})
require("null-ls").setup({})
