# AGENTS

- Scope: Neovim config; primary code in `init.lua` and `lua/**`.
- Build: `docker build . --file Dockerfile --tag neovim`.
- Install deps: `make install` (pynvim, bash-language-server, submodules).
- Plugin sync: `nvim --headless "+Lazy! restore" +qa`.
- Tests: no repo-level test runner defined.
- Formatting: via LSP/none-ls; shfmt, gofmt, goimports, stylua, black, isort, nixfmt.
- Linting: hadolint diagnostics via none-ls; no standalone lint script.
- Indentation: follow existing Lua style (tabs, trailing commas).
- Imports: `local mod = require("...")`; keep require near usage.
- Optional deps: prefer `require("lib").safeRequire`/`pcall` guards.
- Naming: `local` variables; modules return `M` table of functions.
- Plugin specs: table entries with `event/cmd/keys/config/opts`.
- Error handling: use `vim.notify` for user-facing warnings/errors.
- Keymaps: use `vim.keymap.set` with `desc`, `silent`, `noremap`.
- Avoid adding new tooling/scripts unless asked.
- Cursor/Copilot rules: none found in `.cursor/rules/`, `.cursorrules`, `.github/copilot-instructions.md`.
