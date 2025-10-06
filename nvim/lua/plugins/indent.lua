return  {
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        ---@module 'ibl'
        ---type ibl.config
        ots = {},
        config = function()
            require('ibl').setup()
        end
    }
}
