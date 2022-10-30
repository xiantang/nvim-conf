require('telescope').setup {
  extensions = {
    frecency = {
      show_scores = true,
      show_unindexed = true,
      ignore_patterns = {
        "*.git/*",
        "*/tmp/*"
      },
      disable_devicons = false,
    }
  },
}
require("telescope").load_extension("refactoring")
