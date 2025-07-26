local function scstatus()
    if vim.bo.filetype == "supercollider" then
        stat = vim.fn["scnvim#statusline#server_status"]()
        stat = stat:gsub("%%", "♪")
        return stat
    else
        return ""
    end
end

vim.cmd[[set completeopt+=menuone,noselect,popup]]
