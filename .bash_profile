[ -r ~/.bashrc ] && source ~/.bashrc

export PATH="$HOME/bin:/usr/local/bin:/Applications/MacVim.app/Contents/bin:$PATH"
export PS1='\h:\w\$ '
export EDITOR=vim

set -o noclobber

alias qlf='qlmanage -p "$@" >& /dev/null'

export HISTSIZE=100000
export HISTTIMEFORMAT="%F %R%z "
export HISTCONTROL=ignoredups:ignorespace
# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

export mu='wp-content/mu-plugins'
export th='wp-content/themes'
export plug='wp-content/plugins'

export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
alias ls='ls -G'

export COLOR_NC='e[0m' # No Color
export COLOR_WHITE='e[1;37m'
export COLOR_BLACK='e[0;30m'
export COLOR_BLUE='e[0;34m'
export COLOR_LIGHT_BLUE='e[1;34m'
export COLOR_GREEN='e[0;32m'
export COLOR_LIGHT_GREEN='e[1;32m'
export COLOR_CYAN='e[0;36m'
export COLOR_LIGHT_CYAN='e[1;36m'
export COLOR_RED='e[0;31m'
export COLOR_LIGHT_RED='e[1;31m'
export COLOR_PURPLE='e[0;35m'
export COLOR_LIGHT_PURPLE='e[1;35m'
export COLOR_BROWN='e[0;33m'
export COLOR_YELLOW='e[1;33m'
export COLOR_GRAY='e[1;30m'
export COLOR_LIGHT_GRAY='e[0;37m'

alias colorslist="set | egrep 'COLOR_w*'"

gitbranches() {
	for k in `git branch|perl -pe s/^..//`;do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k|head -n 1`\\t$k;done|sort -r
}

github_pr() {
	branch=$(git symbolic-ref --short -q HEAD)
	if [ -n "$branch" ]
	then
		if [ "$branch" == "master" ]; then
			echo "Switch to a feature branch"
			exit 1
		fi

		git push --set-upstream origin "$branch" && hub pull-request -o
	else
		exit 1
	fi
}

alias pr="github_pr"

# Homebrew bash completions
if [ -n "$(which brew)" ] && [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# customize prompt if the git prompt function has been loaded
[ -n $(type -t __git_ps1) ] && export PS1='$(__git_ps1 "\[\033[0;36m\](%s)\[\033[0m\]") \w\$ '

# Load a local configuration file if it exists
[ -r ~/.bash_local ] && source ~/.bash_local

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

