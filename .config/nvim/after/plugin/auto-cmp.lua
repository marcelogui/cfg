local cmp = require ("cmp")
local luasnip = require("luasnip")

require('luasnip.loaders.from_vscode').lazy_load()

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end


local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
    snippet = {
        expand = function(args)
            -- For `vsnip`, uncomment the following.
            -- vim.fn["vsnip#anonymous"](args.body)
            -- For `luasnip`, uncomment the following.
            -- require('luasnip').lsp_expand(args.body)
            -- For snippy, uncomment the following.
            -- require('snippy').expand_snippet(args.body)
            -- For `ultisnips`
            -- vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    formatting = {
        format = function(entry, vim_item)
            -- Kind icons
            -- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) --Concatonate the icons with name of the item-kind
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                spell = "[Spellings]",
                zsh = "[Zsh]",
                buffer = "[Buffer]",
                ultisnips = "[Snip]",
                treesitter = "[Treesitter]",
                calc = "[Calculator]",
                nvim_lua = "[Lua]",
                path = "[Path]",
                nvim_lsp_signature_help = "[Signature]",
                cmdline = "[Vim Command]"
            })[entry.source.name]
            return vim_item
        end,
    },
    mapping = {
        ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    },
    completion = {
        keyword_length = 1,
    },
    matching = {
        disallow_fuzzy_matching = false,
    },
    sources = cmp.config.sources(
    {
        { name = 'nvim_lsp' },
        -- For luasnip users, uncomment the following.
        { name = 'luasnip' },
        { name = 'emmet_vim'}
    },
    {
        { name = 'path' },
    })
})

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' },
    })
})
