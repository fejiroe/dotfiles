return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons'},
    config = function()
        -- ! based on gleipnir evilline
        local lualine = require('lualine')
        -- Color table for highlights
        -- stylua: ignore
        local colors = {
            bg       = '#000000',
            fg       = '#bbc2cf',
            white    = '#ffffff',
            yellow   = '#efff10',
            cyan     = '#00fbfc',
            darkblue = '#081633',
            green    = '#01ffc8',
            orange   = '#FF7810',
            violet   = '#f9a1f1',
            magenta  = '#9442ff',
            blue     = '#115fef',
            red      = '#ff0297',
        }

        local conditions = {
            buffer_not_empty = function()
                return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
            end,
            hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end,
            check_git_workspace = function()
                local filepath = vim.fn.expand('%:p:h')
                local gitdir = vim.fn.finddir('.git', filepath .. ';')
                return gitdir and #gitdir > 0 and #gitdir < #filepath
            end,
        }

        -- Config
        local config = {
            options = {
                -- Disable sections and component separators
                component_separators = '',
                section_separators = '',
                globalstatus = false,
                theme = {
                    -- We are going to use lualine_c an lualine_x as left and
                    -- right section. Both are highlighted by c theme .  So we
                    -- are just setting default looks o statusline
                    normal = { c = { fg = colors.fg, bg = colors.bg } },
                    inactive = { c = { fg = colors.fg, bg = colors.bg } },
                },
            },
            winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
            sections = {},
            inactive_sections = {},
        }

        -- Inserts a component in lualine_c at left section
        local function ins_left(component)
            table.insert(config.winbar.lualine_c, component)
        end

        -- Inserts a component in lualine_x at right section
        local function ins_right(component)
            table.insert(config.winbar.lualine_x, component)
        end

        ins_left {
            function()
                return '▊'
            end,
            color = function()
                -- auto change color according to neovims mode
                local mode_color = {
                    n = colors.white,
                    i = colors.green,
                    v = colors.red,
                    [''] = colors.blue,
                    V = colors.violet,
                    c = colors.magenta,
                    no = colors.d,
                    s = colors.orange,
                    S = colors.orange,
                    [''] = colors.orange,
                    ic = colors.yellow,
                    R = colors.yellow,
                    Rv = colors.violet,
                    cv = colors.red,
                    ce = colors.red,
                    r = colors.cyan,
                    rm = colors.cyan,
                    ['r?'] = colors.cyan,
                    ['!'] = colors.red,
                    t = colors.magenta,
                }
                return { fg = mode_color[vim.fn.mode()] }
            end,
            padding = { left = 0, right = 0 }, 
        }
        
        ins_left {
            -- filesize component
            'filesize',
            cond = conditions.buffer_not_empty,
        }

        ins_left {
            'filename',
            cond = conditions.buffer_not_empty,
            color = { fg = colors.magenta, gui = 'bold' },
        }

        ins_left { 'location' }

        ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

        ins_left {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ' },
            diagnostics_color = {
                error = { fg = colors.red },
                warn = { fg = colors.yellow },
                info = { fg = colors.cyan },
            },
        }
        -- components to right sections
        ins_right {
            -- Lsp server name .
            function()
                local msg = '-'
                local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
                local clients = vim.lsp.get_clients()
                if next(clients) == nil then
                    return msg
                end
                for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        return client.name
                    end
                end
                return msg
            end,
            icon = ' ',
            color = { fg = '#ffffff'},
        }

        ins_right {
            'o:encoding', -- option component same as &encoding in viml
            fmt = string.upper, 
            cond = conditions.hide_in_width,
            color = {fg = colors.green},
        }

        ins_right {
            'fileformat',
            fmt = string.upper,
            icons_enabled = false, 
            color = { fg = colors.green, gui = 'bold' },
        }

        ins_right {
            'branch',
            icon = '',
            color = { fg = colors.violet, gui = 'bold' },
        }

        ins_right {
            'diff',
            symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
            diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.orange },
                removed = { fg = colors.red },
            },
            cond = conditions.hide_in_width,
        }
        lualine.setup(config)
        lualine.hide({place = {'statusline'}})
    end
}
