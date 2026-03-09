vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = { "*.h" },
    callback = function()
        local name = vim.fn.expand("%:t:r"):upper() .. "_H_"
        vim.api.nvim_buf_set_lines(0, 0, -1, false, {
            "#ifndef " .. name,
            "#define " .. name,
            "",
            "",
            "",
            "#endif /* !" .. name .. " */"
        })
        vim.api.nvim_win_set_cursor(0, {4, 0})
    end
})

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = { "*.hh"},
    callback = function()
        vim.api.nvim_buf_set_lines(0, 0, -1, false, {
            "#pragma once",
            "",
        })
        vim.api.nvim_win_set_cursor(0, {2, 0})
    end
})

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "CMakeLists.txt",
    callback = function()
        vim.api.nvim_buf_set_lines(0, 0, -1, false, {
            "cmake_minimum_required(VERSION 3.10)",
            "project(MyProject C CXX)",
            "",
            "set(CMAKE_C_STANDARD 99)",
            "set(CMAKE_CXX_STANDARD 20)",
            "",
            "add_executable(${PROJECT_NAME} main.c)"
        })
        vim.api.nvim_win_set_cursor(0, {7, 0})
    end
})
