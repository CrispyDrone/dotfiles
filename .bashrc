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
Requests='E:\Interparking\Requests'
MANPATH=$MANPATH:$HOME/share/man

# functions
surf()
{
	# $1 should always be the argument to http-prompt's `--env`
	declare env
	declare env_dir
	declare skip_one
	declare -a url_params
	declare -a args

	env="$1"
	env_dir=$(dirname "${env}")
	skip_one=false

	shift

	# All other arguments need to be parsed. 
	# I will add support for changing the url parameters by allowing a `-u` flag followed by a new value for one of the url tokens as saved in the request file.
	for arg do

		if [ ${skip_one} = true ]
		then
			skip_one=false
			continue
		fi

		shift

		if [ "$arg" = '-u' ]
		then
			url_params+=("${1}")
			shift
			skip_one=true
			continue
		fi

		set -- "$@" "$arg"
	done

	args="$@"
	# Other flags can be supported as well such as `-r` which would be followed by a raw url. Cannot be combined with `-u`.

	# Any other parameters are passed as *is* to `http-prompt`

	if [ ! -f "${env_dir}"/.init ] || [ ! -f  "${env_dir}"/.cleanup ]
	then
		winpty http-prompt --env "${env}" "${args[@]}"
	else
		. "${env_dir}"/.init "${url_params[@]}"
		winpty http-prompt --env "${env}" "${args[@]}"
		. "${env_dir}"/.cleanup "${url_params[@]}"
	fi
}
