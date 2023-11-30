vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.netrw_banner = 0

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',
	'ThePrimeagen/harpoon',


	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'williamboman/mason.nvim', config = true }, 'williamboman/mason-lspconfig.nvim',

			{ 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

			'folke/neodev.nvim',
		},
	},

	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',

			'hrsh7th/cmp-nvim-lsp',

			'rafamadriz/friendly-snippets',
		},
	},

	{
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

				local gs = package.loaded.gitsigns
				vim.keymap.set({ 'n', 'v' }, ']c', function()
					if vim.wo.diff then return ']c' end
					vim.schedule(function() gs.next_hunk() end)
					return '<Ignore>'
				end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
				vim.keymap.set({ 'n', 'v' }, '[c', function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function() gs.prev_hunk() end)
					return '<Ignore>'
				end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
			end,
		},
	},

	{
		'rose-pine/neovim',
		priority = 1000,
		config = function()
			require('rose-pine').setup({
				disable_background = 'true',
				disable_float_background = 'true'
			})
			vim.cmd.colorscheme 'rose-pine'
		end,
	},


	{ 'numToStr/Comment.nvim',  opts = {} },

	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
		},
	},

	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
	},

	{ import = 'custom.plugins' },
}, {})

vim.o.tabstop = 2;
vim.o.shiftwidth = 2;

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.swapfile = false

vim.o.relativenumber = true
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#45b6fe' })

vim.o.mouse = 'a'

vim.o.clipboard = 'unnamedplus'

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.signcolumn = 'yes'

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', 'L', "$")
vim.keymap.set('n', 'H', "^")
vim.keymap.set('v', 'L', "$")
vim.keymap.set('v', 'H', "^")
vim.keymap.set('n', '<space>x', ":x<CR>")
vim.keymap.set('n', '<space>l', ":bn<CR>")
vim.keymap.set('n', '<space>h', ":bp<CR>")
vim.keymap.set('n', '<leader>w=', '<C-w>=', { desc = 'Equally high and wide' })
vim.keymap.set('n', '<leader>w_', '<C-w>_', { desc = 'Max out the height' })
vim.keymap.set('n', '<leader>wo', '<C-w>o', { desc = 'Close all other windows' })
vim.keymap.set('n', '<leader>wq', '<C-w>q', { desc = 'Quit a window' })
vim.keymap.set('n', '<leader>ws', '<C-w>s', { desc = 'Split window' })
vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>ww', '<C-w>w', { desc = 'Switch windows' })
vim.keymap.set('n', '<leader>wx', '<C-w>x', { desc = 'Swap current with next' })
vim.keymap.set('n', '<leader>w|', '<C-w>|', { desc = 'Max out the width' })
vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = 'go to left window' })
vim.keymap.set('n', '<leader>wj', '<C-w>j', { desc = 'Go to top window' })
vim.keymap.set('n', '<leader>wk', '<C-w>k', { desc = 'Go to bottom window' })
vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = 'Go to right window' })

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require('lint').try_lint()
	end
})

require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				['<C-u>'] = false,
				['<C-d>'] = false,
			},
		},
	},
}

pcall(require('telescope').load_extension, 'fzf')

require('harpoon').setup({
})


vim.keymap.set('n', '<leader>ce', function()
	require('copilot.suggestion').toggle_auto_trigger()
end, { desc = 'enable suggestion' });

vim.keymap.set('n', '<leader><space>', function()
	require('harpoon.ui').toggle_quick_menu()
end, { desc = 'Find harpoon files' });

vim.keymap.set('n', '<leader>b', function()
	require('harpoon.mark').add_file()
end, { desc = 'add harpoon files' });

vim.keymap.set('n', '<leader>1', function()
	require('harpoon.ui').nav_file(1)
end, { desc = 'go to file 1' });

vim.keymap.set('n', '<leader>2', function()
	require('harpoon.ui').nav_file(2)
end, { desc = 'go to file 2' });

vim.keymap.set('n', '<leader>3', function()
	require('harpoon.ui').nav_file(3)
end, { desc = 'go to file 3' });

vim.keymap.set('n', '<leader>4', function()
	require('harpoon.ui').nav_file(4)
end, { desc = 'go to file 4' });

vim.keymap.set('n', '<leader>5', function()
	require('harpoon.ui').nav_file(5)
end, { desc = 'go to file 4' });


vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>/', function()
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>st', function() vim.cmd(':TodoTelescope') end, { desc = '[S]earch [R]esume' })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

require('nvim-treesitter.configs').setup {
	ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim' },

	auto_install = true,

	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<c-space>',
			node_incremental = '<c-space>',
			scope_incremental = '<c-s>',
			node_decremental = '<M-space>',
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				['aa'] = '@parameter.outer',
				['ia'] = '@parameter.inner',
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner',
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				[']m'] = '@function.outer',
				[']]'] = '@class.outer',
			},
			goto_next_end = {
				[']M'] = '@function.outer',
				[']['] = '@class.outer',
			},
			goto_previous_start = {
				['[m'] = '@function.outer',
				['[['] = '@class.outer',
			},
			goto_previous_end = {
				['[M'] = '@function.outer',
				['[]'] = '@class.outer',
			},
		},
		swap = {
			enable = true,
			swap_next = {
				['<leader>a'] = '@parameter.inner',
			},
			swap_previous = {
				['<leader>A'] = '@parameter.inner',
			},
		},
	},
}

local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
	nmap('<leader>fm', vim.lsp.buf.format, 'Format')
	nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
	nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

	-- See `:help K` for why this keymap
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
end

local servers = {
	pyright = {},
	emmet_ls = { filetypes = { 'html' }, single_file_support = true },
	marksman = { filetypes = { 'markdown' }, single_file_support = true },
	tsserver = {
		init_options = {
			disableSuggestions = true,
		}
	},
	html = { filetypes = { 'html', 'twig', 'hbs' } },
	dockerls = {},
	gopls = {},
	csharp_ls = {},
	-- sqls = {},
	jdtls = {},
	svelte = {},
	cssls = { filetypes = { "css", "scss", "less" } },

	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}
require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
	function(server_name)
		require('lspconfig')[server_name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
			single_file_support = (servers[server_name] or {}).single_file_support,
			init_options = (servers[server_name] or {}).init_options
		}
	end
}

local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert {
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete {},
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
	sources = {
		{ name = 'nvim_lsp' },
	},
}

local mygroup = vim.api.nvim_create_augroup("loading_netrwPlugin",
	{ clear = true })
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	pattern = { "*" },
	callback = function()
		-- Getting the file name that you pass when you launch nvim,
		local current_file = vim.fn.expand("%")
		-- if we have already file_name, then, we edit it
		if current_file ~= "" then
			vim.cmd(":silent! edit " .. current_file)
		else
			-- We will check if the window (buffer) is the lazy nvim, as it conflict if the buffer (popup menu) is lazy
			local lazy_popup_buf_exists = false
			-- We will get list of all current opened buffers
			local buf_list = vim.api.nvim_list_bufs()
			for _, buf in ipairs(buf_list) do
				-- We will obtain from the table only the filetype
				local buf_ft = vim.api.nvim_buf_get_option(buf, 'filetype')
				if buf_ft == "lazy" then
					lazy_popup_buf_exists = true
				end
			end -- Check if vim-floaterm is loaded
			local has_floaterm, _ = pcall(require, 'floaterm')
			if not lazy_popup_buf_exists and not has_floaterm then
				-- Then we can safely loading netrwPlugin at startup
				vim.cmd(":silent! Explore")
			end
		end
	end,
	group = mygroup
})
