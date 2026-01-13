# Repository Guidelines

## Project Structure & Module Organization

- Root contains dotfiles (for example, `.zshrc`, `.gitconfig`, `.tmux.conf`) that are symlinked into `$HOME`.
- `.config/` holds app configs (for example, `nvim/`, `gh/`, `coc/`) and is linked into `$HOME/.config`.
- `init/` stores OS-specific setup (`init/macos`, `init/wsl`, `init/windows`) with Brewfiles and setup scripts.
- `bin/` provides helper scripts like `bin/make_brewfile.sh`.
- `img/` contains assets (for example, wallpapers).

## Build, Test, and Development Commands

```sh
make help            # list Makefile targets
make deploy          # symlink dotfiles into $HOME and $HOME/.config
make list            # list dotfiles that would be deployed
make clean           # remove deployed dotfiles and this repo (destructive)
make brewfile        # regenerate Brewfile using bin/make_brewfile.sh
```

```sh
bash install.sh                 # clone + run OS setup + deploy
bash init/macos/setup.sh        # macOS packages + links
bash init/wsl/setup.sh          # WSL packages + shell setup
powershell init/windows/setup.ps1  # Windows winget import
```

## Coding Style & Naming Conventions

- Shell scripts use bash; keep 2-space indentation for blocks and 4-space indentation for continuations.
- Dotfiles should mirror their target path and name (for example, `.gitignore_global`, `.config/nvim/`).
- Prefer lowercase names and keep OS-specific changes under `init/<os>/`.
- No repo-wide formatter; keep Markdown concise and avoid `TODO` (textlint rule).

## Testing Guidelines

- No automated test suite is present.
- Validate changes by running `make deploy` on the target OS and verifying symlinks and shell startup.
- For config updates, open the affected tool (for example, `zsh`, `git`, `nvim`) to confirm behavior.

## Commit & Pull Request Guidelines

- Recent history favors short, imperative messages with optional prefixes like `feat:`, `fix:`, `chore:`, and occasional Japanese summaries. Follow that pattern.
- Add a scope when it clarifies the change (for example, `feat(config): ...`).
- PRs should call out the target OS (`macos`, `wsl`, `windows`), list changed dotfiles, and note validation steps.
- Include screenshots only when changing visible UI (terminal/editor themes).

## Security & Configuration Notes

- `make clean` removes dotfiles from `$HOME` and deletes the repo; use it cautiously.
- Setup scripts run `sudo` and install packages; review before running on new machines.
