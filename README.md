# dotfiles

My macOS rice: **Vesper** colours everywhere, **Rift** tiling, a two-island **SketchyBar** around the notch, and **JankyBorders**.
Built on [advtszn/dotfiles](https://github.com/advtszn/dotfiles), managed with [chezmoi](https://www.chezmoi.io/), guarded by [gitleaks](https://github.com/gitleaks/gitleaks).

## What's in here

|                | Tool                                                                                                            | Config                                                                  |
| -------------- | --------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| Window manager | [Rift](https://github.com/acsandmann/rift): BSP tiling, virtual workspaces, 3-finger swipes                     | `.config/rift/config.toml`                                              |
| Bar            | [SketchyBar](https://github.com/FelixKratz/SketchyBar): workspaces + app icons, net/cpu graphs, battery, clock | `.config/sketchybar/`                                                   |
| Borders        | [JankyBorders](https://github.com/FelixKratz/JankyBorders)                                                      | `.config/borders/bordersrc`                                             |
| Terminal       | Rex with a Vesper port, [Ghostty](https://ghostty.org) with Vesper, blur, Monaspace Neon     | `rex/themes/Vesper`, `Library/Application Support/com.mitchellh.ghostty/config` |
| Shell          | zsh + [oh-my-zsh](https://ohmyz.sh) + [Powerlevel10k](https://github.com/romkatv/powerlevel10k) in Vesper       | `.zshrc`, `.p10k.zsh`                                                   |
| Multiplexer    | tmux + [tmux-nova](https://github.com/o0th/tmux-nova)                                                           | `.tmux.conf`, `.tmux/scripts/`                                          |
| Editor         | [Zed](https://zed.dev) with the Vesper extension, [Xcode](https://developer.apple.com/xcode/) with a Vesper theme | `.config/zed/settings.json`, `Library/Developer/Xcode/UserData/FontAndColorThemes/` |
| Coding agents  | [Claude Code](https://claude.com/claude-code) and [pi](https://pi.dev), both with a Vesper theme                | `.claude/themes/`, `.pi/agent/`                                         |
| Notes          | [Obsidian](https://obsidian.md) with a Vesper CSS snippet                                                       | `obsidian/snippets/vesper.css` (repo only)                              |
| Files          | [lf](https://github.com/gokcehan/lf), [lsd](https://github.com/lsd-rs/lsd)                                      | `.config/lf/`, `.config/lsd/`                                           |
| Fetch, monitor | [fastfetch](https://github.com/fastfetch-cli/fastfetch), [btop](https://github.com/aristocratos/btop)           | `.config/fastfetch/`, `.config/btop/`                                   |
| Packages       | Homebrew bundle                                                                                                 | `.Brewfile`                                                             |

**Palette**: [Vesper](https://github.com/raunofreiberg/vesper):
`#101010` background · `#ffffff` text · `#ffc799` peach · `#99ffe4` mint · `#ff8080` red · `#a0a0a0` grey · `#505050` dim

**Font**: [Monaspace Neon](https://monaspace.githubnext.com) with texture healing and ligatures in Ghostty and the bar.

**Wallpaper**: `PPLX-Silhouette-Above-Clouds` from [advtszn/dotfiles](https://github.com/advtszn/dotfiles/tree/main/wallpapers) ([PPLX Digital Wallpapers: I](https://perplexity.supply/products/pplx-digital-wallpapers-i)). Not in this repo.

## Keys

Window management is `⌥` (Option), with `⌃⌘` + arrows for moving between windows.

| Keys                                            | Action                                    |
| ----------------------------------------------- | ----------------------------------------- |
| `⌥ 1–5`                                         | switch workspace                          |
| `⌥⇧ 1–5`                                        | send window to workspace                  |
| `⌃ ←` / `⌃ →` · 3-finger swipe                  | previous / next workspace                 |
| `⌃⌘ ← ↓ ↑ →`                                    | focus left / down / up / right            |
| `⌃⌘⇧ ← ↓ ↑ →`                                   | move window                               |
| `⌥ =` / `⌥ -` · `⌥⇧ =` / `⌥⇧ -`                 | wider / narrower · taller / shorter       |
| `⌥ /`                                           | flip split direction                      |
| `⌥ ,`                                           | stack windows                             |
| `⌥ F` · `⌥⇧ F`                                  | fullscreen (keep gaps) · edge to edge     |
| `⌥⇧ Space`                                      | float at a sensible size / back to tiling |
| `⌥ Tab`                                         | last workspace                            |
| `⌥⇧ ;` then `R` / `F` / `⌃⌘⇧ ←↓↑→` / `U` / `Esc` | balance / float / join / unjoin / reload |

Workspaces: 1 web (Safari), 2 code (Rex, Ghostty, Zed, Xcode), 3 chat (Slack, Teams, Music).

## New machine

```sh
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install chezmoi gitleaks
git clone https://github.com/woosal1337/dotfiles ~/Documents/GitHub/dotfiles
chezmoi init --apply --source ~/Documents/GitHub/dotfiles   # installs the .Brewfile and sets the macOS defaults
```

chezmoi runs in symlink mode: files in `~` link into the clone, so keep it where it is. Executables, `btop.conf` and Zed's settings are copied instead; pull changes to those back with `chezmoi re-add`.

Then, once:

1. Install oh-my-zsh, the prompt and the plugins:
   ```sh
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
   C="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
   git clone --depth=1 https://github.com/romkatv/powerlevel10k "$C/themes/powerlevel10k"
   git clone https://github.com/zsh-users/zsh-autosuggestions "$C/plugins/zsh-autosuggestions"
   git clone https://github.com/zsh-users/zsh-completions "$C/plugins/zsh-completions"
   git clone https://github.com/zsh-users/zsh-syntax-highlighting "$C/plugins/zsh-syntax-highlighting"
   ```
   Credentials go in `~/.zsh_private`, which `.zshrc` sources and this repo never holds. Running `p10k configure` again overwrites the Vesper prompt colours.
2. `rift service install && rift service start`, and grant **Accessibility** when asked
3. `brew services start sketchybar && brew services start borders`
4. `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`, then `prefix + I` in tmux
5. Install [Zed](https://zed.dev/download) (its Homebrew cask needs sudo for the CLI link). It installs the Vesper extension on first launch.
6. Rex: run **Import Theme File** from the command palette and pick `rex/themes/Vesper`. With Remote Control on: `rex -C <client> do client.theme.import path="$PWD/rex/themes/Vesper"`
7. Obsidian: copy `obsidian/snippets/vesper.css` into `<vault>/.obsidian/snippets/`, turn it on under Settings → Appearance → CSS snippets, and set the accent to `#ffc799`
8. Claude Code: `/theme` → Vesper. Its `settings.json` stays out of this repo.
9. Desktop & Dock: keep a single macOS Space (Rift does workspaces)

## Notes

- **Rex**: `rex/themes/Vesper` is a Ghostty-format port of Vesper, with the same terminal palette as my JetBrains, Fleet and Zeron ports.
- **pi**: `settings.json` uses Claude through [pi-claude-bridge](https://github.com/elidickinson/pi-claude-bridge) with Opus 5.5 as the default, enables the Claude 5 models and Grok 4.7, shows tokens per second with [pi-tps-footer](https://github.com/kmike/pi-tps-footer), and keeps up to 500K recent tokens when compacting. `claude-bridge.json` sets the bridge to the Claude Max plan. pi installs the listed packages on its next start. `auth.json` (credentials) and `models-store.json` (rebuilt by pi) are left out on purpose.
- **Brewfile**: refresh it with `brew bundle dump --file ~/.Brewfile --force --no-vscode --no-npm`. `~/.Brewfile` links here, so the change shows up in `git status`.
- **Secrets**: the pre-commit hook runs gitleaks with `.gitleaks.toml` and refuses commits with keys, IP addresses, email addresses or `.pem` names. `chezmoi add` refuses files that look like secrets.

## Credits

The rice and most of these configs come from [advtszn/dotfiles](https://github.com/advtszn/dotfiles) · [Vesper](https://github.com/raunofreiberg/vesper) by Rauno Freiberg · [Rift](https://github.com/acsandmann/rift) by acsandmann · [SketchyBar](https://github.com/FelixKratz/SketchyBar), [JankyBorders](https://github.com/FelixKratz/JankyBorders) by Felix Kratz · [sketchybar-app-font](https://github.com/kvndrsslr/sketchybar-app-font) · [Monaspace](https://monaspace.githubnext.com) by GitHub Next.

## License

MIT. See `LICENSE`.
