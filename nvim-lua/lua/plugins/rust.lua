return {
    {
        "simrat39/rust-tools.nvim",
        config = function()
            require("rust-tools").setup()
        end,
    },
    {
        "rust-lang/rust.vim",
        config = function()
            vim.cmd([[
                let g:rustfmt_command = "rustfmt"
                let g:rust_clip_command = 'pbcopy'
                let g:rustfmt_autosave = 1
                let g:rustfmt_emit_files = 1
                let g:rustfmt_fail_silently = 0
                " let g:rustfmt_options = '--edition 2018'
                let $RUST_SRC_PATH = systemlist("rustc --print sysroot")[0] . "/lib/rustlib/src/rust/src"
            ]])
        end
    }
}