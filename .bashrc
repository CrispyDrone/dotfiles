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
	declare url_command
	declare url_env_export
	declare url_var
	declare url
	declare swagger_env_export
	declare swagger_url
	declare current_dir
	declare old_current_dir
	declare g_dir
	declare -i g_init_exists
	declare -i g_cleanup_exists
	declare missing_g_file='File %s does not exist. Skipping variable substitution.'

	env="$1"
	env_dir=$(dirname "${env}")
	skip_one=false

	shift

	if [ ${1:-''} = '-s' ]
	then
		if [ ! -f "${env_dir}/.init" ]
		then
			return 1;
		fi

		url_command=$(<"${env}")
		url_var="${url_command##*\$\{}"
		url_var="${url_var%%\}}"
		url_env_export=$(grep -i "${url_var}=" "${env_dir}/.init")
		url=${url_env_export##*=}

		swagger_env_export=$(grep -i "${url_var}_SWAGGER=" "${env_dir}/.init")
		swagger_url=${swagger_env_export##*=}

		winpty http-prompt "$url" --spec "$swagger_url"
		return 0;
	fi

	# All other arguments need to be parsed. 
	# I will add support for changing the url parameters by allowing a `-u` flag followed by a new value for one of the url tokens as saved in the request file.
	# Other flags can be supported as well such as `-r` which would be followed by a raw url. Cannot be combined with `-u`.
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

	# Any other parameters are passed as *is* to `http-prompt`
	args="$@"

	# Find the directory containing .g.init and .g.cleanup, if it doesn't exist, execute without replacing variables and echo warning
	current_dir="${env_dir}"

	while [ ! "${current_dir}" = "${old_current_dir}" ]
	do
		# awkward because of lack of xor operator
		[ -f  "${current_dir}"/.g.init ]; g_init_exists=$?
		[ -f  "${current_dir}"/.g.cleanup ]; g_cleanup_exists=$?

		if [ ! "${g_init_exists}" -eq "${g_cleanup_exists}" ]
		then
			if [ "${g_init_exists}" -eq 0 ]
			then
				printf "${missing_g_file}\n" ".g.cleanup"
			else
				printf "${missing_g_file}\n" ".g.init"
			fi
			break
		fi

		if [ -f "${current_dir}"/.g.init ] && [ -f "${current_dir}"/.g.cleanup ]
		then
			g_dir="${current_dir}"
			break
		fi

		old_current_dir="${current_dir}"
		current_dir="${current_dir}"/..
	done

	# start http-prompt
	if [ -z "${g_dir}" ]
	then
		winpty http-prompt --env "${env}" "${args[@]}"
	else
		. "${g_dir}"/.g.init "${env_dir}" "${url_params[@]}"
		winpty http-prompt --env "${env}" "${args[@]}"
		. "${g_dir}"/.g.cleanup "${env_dir}" "${url_params[@]}"
	fi

	return 0;
}

jq()
{
	jq-win64.exe "$@"
}
