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
	# $1 should always be the argument to http-prompt's `--env`
	env="$1"

	# All other arguments need to be parsed. 
	# I will add support for changing the url parameters by allowing a `-u` flag followed by a new value for one of the url tokens as saved in the request file.
	# Other flags can be supported as well such as `-r` which would be followed by a raw url. Cannot be combined with `-u`.

	# Any other parameters are passed as *is* to `http-prompt`

	# Instead of having git branches for the different environments. I think it will be easier to just split each request folder into 4 folders, one per environment.
	# By default anything will operate on `dev` environment, unless you manually specify `--env=dev` or change the environment variable `REQUESTS_ENVIRONMENT` for example.
	shift
	args="$@"

	if [ ! -f .init ] || [ ! -f .cleanup ]
	then
		winpty http-prompt --env "${env}" "${args}"
	else
		. .init
		winpty http-prompt --env "${env}" "${args}"
		. .cleanup
	fi
}
