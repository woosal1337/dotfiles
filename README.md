# dotfiles

My settings, themes, and patches, one folder per app.

## Rex

[`rex/themes/Vesper`](rex/themes/Vesper) is a Ghostty-format port of [Vesper](https://github.com/raunofreiberg/vesper) by Rauno Freiberg. It uses the same terminal palette as my JetBrains, Fleet, and Zeron ports.

To install it, run **Import Theme File** from the Rex command palette and pick the file. With Remote Control turned on, you can also run:

```
rex -C <client> do client.theme.import path="$PWD/rex/themes/Vesper"
```

## pi

[`pi/`](pi) holds my global [pi](https://pi.dev) settings. `~/.pi/agent/` links to these files, so changes made in pi show up here.

- `settings.json` uses Claude through [pi-claude-bridge](https://github.com/elidickinson/pi-claude-bridge) by default, with Opus 5.5 as the default model. It enables the Claude 5 models and Grok 4.7. It also shows tokens per second with [pi-tps-footer](https://github.com/kmike/pi-tps-footer), and keeps up to 500K recent tokens when compacting Claude sessions.
- `claude-bridge.json` sets the bridge to the Claude Max plan.

To install, link both files from the repo root:

```
mkdir -p ~/.pi/agent
ln -s "$PWD/pi/settings.json" ~/.pi/agent/settings.json
ln -s "$PWD/pi/claude-bridge.json" ~/.pi/agent/claude-bridge.json
```

The next time pi starts, it installs the packages that `settings.json` lists.

These files are left out on purpose. `auth.json` holds credentials. `models-store.json` is a model list that pi rebuilds itself. `extensions/herdr-agent-state.ts` belongs to herdr, which reinstalls and overwrites it.

## zsh

[`zsh/`](zsh) holds my `.zshrc`, `.p10k.zsh`, and an empty `.hushlogin`, which hides the "Last login" line. `~/` links to these files.

The prompt and highlighting use the Vesper colors. The prompt shows a peach folder icon, a gray path with `~` and the repo in bold white, the git branch in mint, and a `❯` that turns red after a failed command. Commands are peach, strings mint, flags gray, unknown commands red, and autosuggestions `#505050`.

It needs [oh-my-zsh](https://ohmyz.sh) and a [Nerd Font](https://www.nerdfonts.com) (v3) for the icons. Install oh-my-zsh, the theme, and the plugins:

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
C="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git clone --depth=1 https://github.com/romkatv/powerlevel10k "$C/themes/powerlevel10k"
git clone https://github.com/zsh-users/zsh-autosuggestions "$C/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-completions "$C/plugins/zsh-completions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$C/plugins/zsh-syntax-highlighting"
```

Then link the files from the repo root:

```
for f in .zshrc .p10k.zsh .hushlogin; do ln -s "$PWD/zsh/$f" ~/$f; done
```

Credentials go in `~/.zsh_private`, which `.zshrc` sources and this repo never holds. Running `p10k configure` again overwrites the Vesper prompt colors.

## License

MIT. See `LICENSE`.
