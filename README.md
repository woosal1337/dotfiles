# dotfiles

My settings, themes, and patches, one folder per app.

## Rex

[`rex/themes/Vesper`](rex/themes/Vesper) is a Ghostty-format port of [Vesper](https://github.com/raunofreiberg/vesper) by Rauno Freiberg. It uses the same terminal palette as my JetBrains, Fleet, and Zeron ports.

To install it, run **Import Theme File** from the Rex command palette and pick the file. With Remote Control turned on, you can also run:

```
rex -C <client> do client.theme.import path="$PWD/rex/themes/Vesper"
```

## License

MIT. See `LICENSE`.
