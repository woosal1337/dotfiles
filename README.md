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

## License

MIT. See `LICENSE`.
