# aliases
alias gvim="'/c/Program Files (x86)/Vim/vim81/gvim.exe'"
alias config='/usr/bin/env git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# TODO: This should only be run in case of the terminal emulator mintty being used.
# See the following links:
# 1. https://github.com/mintty/mintty/wiki/Tips#terminal-type-detection--check-if-running-inside-mintty 
# 2. https://github.com/mintty/utils/blob/master/terminal
alias http-prompt='winpty http-prompt'

# variables
Tickets='E:\Interparking\Tickets'
MANPATH=$MANPATH:$HOME/share/man

# functions
# todo: support any path, not only from within the actual directory
#surf()
#{
#	request="$1"
#	shift
#	args="$@"
#
#	if [ -f "${request}"/.init && -f "${request}"/.cleanup || echo 'Found .init but no matching .cleanup' >&2 ]
#	then
#		. "${request}"/.init
#		winpty http-prompt --env tmp/"${request}" "${args}"
#		. "${request}"/.cleanup
#	else
#		winpty http-prompt --env "${request}" "${args}"
#	fi
#}

surf()
{
	env="$1"
	echo "$request"
	shift
	args="$@"

	if [ ! -f .init ] || [ ! -f .cleanup ]
	then
		winpty http-prompt --env "${env}" "${args}"
	else
		. .init
		winpty http-prompt --env tmp/"${env}" "${args}"
		. .cleanup
	fi
}
