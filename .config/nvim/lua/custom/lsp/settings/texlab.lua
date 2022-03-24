return {
    settings = {
        texlab = {
            build = {
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "-pvc", "%f" },
                onSave = true 
            },
            forwardSearch = {
                executable = "zathura",
                    args = { "--unique", "file:%p#src:%l%f" }
            }
        },
    },
}
