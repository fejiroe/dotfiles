return  {
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        ---@module 'ibl'
        ---tyfe ibl.config
        ots = {},
        config = function()
            require('ibl').setup()
        end
    }
}
