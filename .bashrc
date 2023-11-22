# variables
export repos=/w/Projects/Coding/repos
MANPATH=$MANPATH:$HOME/share/man

# aliases
alias gvim="'/c/Program Files/Vim/vim82/gvim.exe'"
alias config='/usr/bin/env git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# TODO: This should only be run in case of the terminal emulator mintty being used.
# See the following links:
# 1. https://github.com/mintty/mintty/wiki/Tips#terminal-type-detection--check-if-running-inside-mintty 
# 2. https://github.com/mintty/utils/blob/master/terminal
alias http-prompt='winpty http-prompt'


# functions
dlvid()
{
	url="$1"
	shift
	yt-dlp -o "$(date +%Y-%m-%d)-%(title)s.%(ext)s" --no-overwrites --restrict-filenames "$@" -- "${url}"
	#yt-dlp --format bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best -o "$(date +%Y-%m-%d)-%(title)s.%(ext)s" --no-overwrites --restrict-filenames --external-downloader=aria2c --external-downloader-args --min-split-size=1M --max-connection-per-server=16 --max-concurrent-downloads=16 --split=16 "$@" -- "${url}"
}

dlsong()
{
	url="$1"
	shift
	yt-dlp "${url}" -x -o "/w/Library/Music/Downloads/todo/$(date +%Y-%m-%d)-%(title)s.%(ext)s" --no-overwrites --restrict-filenames --external-downloader=aria2c --external-downloader-args '--min-split-size=1M --max-connection-per-server=16 --max-concurrent-downloads=16 --split=16' "$@"
}

dlpage()
{
	local url filename

	while (($# > 0))
	do
		case "${1}" in
			# TODO: don't assume it's a relative filename
			-o) filename="$(pwd)/${2}" && shift;;
			-u) url="${2}" && shift;;
			*) url="${1}"
		esac

		shift
	done

	[ -z "${filename}" ] && filename="${url##*/}" && filename="${filename%%.*}" && filename="$(pwd)/$(date +%Y%m%dT%H%M%S)-${filename}.pdf"

	chrome --headless --print-to-pdf="${filename}" --user-data-dir="$CHROME_USER_DATA_DIR" "${url}"
	#echo "filename: ${filename}"
}

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
