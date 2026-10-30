# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ~/.zshrc — minimal, native-first setup

# Drop duplicate PATH/fpath entries that installers keep prepending.
typeset -U path fpath

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)  # before oh-my-zsh, so its compinit picks it up
# <<< grok installer <<<

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-completions zsh-autosuggestions zsh-syntax-highlighting)
source "$ZSH/oh-my-zsh.sh"

# Vesper colors: peach #FFC799, mint #99FFE4, red #FF8080, grays #A0A0A0 / #8B8B8B / #505050.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#505050'
ZSH_HIGHLIGHT_STYLES+=(
  unknown-token             'fg=#FF8080'
  reserved-word             'fg=#A0A0A0'
  alias                     'fg=#FFC799'
  suffix-alias              'fg=#FFC799'
  global-alias              'fg=#FFC799'
  builtin                   'fg=#FFC799'
  function                  'fg=#FFC799'
  command                   'fg=#FFC799'
  precommand                'fg=#FFC799,italic'
  hashed-command            'fg=#FFC799'
  commandseparator          'fg=#A0A0A0'
  path                      'fg=#FFFFFF,underline'
  path_prefix               'fg=#FFFFFF,underline'
  globbing                  'fg=#99FFE4'
  history-expansion         'fg=#99FFE4'
  single-hyphen-option      'fg=#A0A0A0'
  double-hyphen-option      'fg=#A0A0A0'
  back-quoted-argument      'fg=#99FFE4'
  single-quoted-argument    'fg=#99FFE4'
  double-quoted-argument    'fg=#99FFE4'
  dollar-quoted-argument    'fg=#99FFE4'
  dollar-double-quoted-argument 'fg=#FFFFFF'
  back-double-quoted-argument   'fg=#FFFFFF'
  assign                    'fg=#FFFFFF'
  redirection               'fg=#A0A0A0'
  comment                   'fg=#8B8B8B,italic'
  arg0                      'fg=#FFC799'
  default                   'fg=#FFFFFF'
)

# Node — nvm (installed via Homebrew)
export NVM_DIR="$HOME/.nvm"
if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
  . "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
elif [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
fi

# pyenv — only activates if you install it later
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null 2>&1 && eval "$(pyenv init -)"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Maestro needs a JRE; brew openjdk is keg-only so it is not on PATH by default.
export JAVA_HOME=/opt/homebrew/opt/openjdk
export PATH="$JAVA_HOME/bin:$HOME/.maestro/bin:$PATH"

# User-local bin (uv-installed tools, the standalone Codex CLI and Antigravity CLI land here)
export PATH="$HOME/.local/bin:$PATH"

# Pi also sends copies over OSC 52, so a Herdr window on another machine gets them.
export PI_CLIPBOARD_OSC52=1

# Private credentials, never committed. Kept out of .zshrc so that file stays shareable.
[ -f ~/.zsh_private ] && source ~/.zsh_private

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
