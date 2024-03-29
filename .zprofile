export ZSH_HOST_OS=$(uname | awk '{print tolower($0)}')
export EDITOR=nvim
export PATH="$HOME/bin${PATH+:$PATH}";

case $ZSH_HOST_OS in
  darwin*)
  export HOMEBREW_PREFIX="/opt/homebrew";
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
  export HOMEBREW_REPOSITORY="/opt/homebrew";
  export HOMEBREW_SHELLENV_PREFIX="/opt/homebrew";
  export PATH="/Applications/MacVim.app/Contents/bin:/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
;;
esac

export HISTORY_IGNORE="(ls|cd|cd -|pwd|exit|date|* --help)"

# share history across multiple zsh sessions
setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# do not store duplications
setopt HIST_IGNORE_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS

export HISTSIZE=100000

bindkey -e

gitbranches() {
	for k in `git branch|perl -pe s/^..//`;do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k|head -n 1`\\t$k;done|sort -r
}

