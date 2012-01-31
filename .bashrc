[ -z "$PS1" ] && return

export HISTCONTROL=ignoredups:erasedups 
export HISTSIZE=8192
export HISTFILESIZE=8192

## http://wiki.bash-hackers.org/internals/shell_options
shopt -s expand_aliases
shopt -s cdspell
shopt -s hostcomplete
shopt -s globstar
shopt -s checkwinsize
shopt -s histappend
#shopt -s extglob


if [ -x /usr/bin/cowsay ]; then
	# cowsay <<< "bad formatting"
	fortune -a # | /usr/bin/cowsay -f tux -W $(($COLUMNS - 16))
else
	fortune -a
fi

#export PS1='\[\033[0;31m\][\A]\[\033[0;m\][\[\033[0;34m\]\u\[\033[0m\]@\[\033[0;33m\]\h\[\033[0;m\]:\w]\[\033[0;32m\]\$ \[\033[0m\]'
export txtblk='\e[0;30m' # Black - Regular
export txtred='\e[0;31m' # Red
export txtgrn='\e[0;32m' # Green
export txtylw='\e[0;33m' # Yellow
export txtblu='\e[0;34m' # Blue
export txtpur='\e[0;35m' # Purple
export txtcyn='\e[0;36m' # Cyan
export txtwht='\e[0;37m' # White
export bldblk='\e[1;30m' # Black - Bold
export bldred='\e[1;31m' # Red
export bldgrn='\e[1;32m' # Green
export bldylw='\e[1;33m' # Yellow
export bldblu='\e[1;34m' # Blue
export bldpur='\e[1;35m' # Purple
export bldcyn='\e[1;36m' # Cyan
export bldwht='\e[1;37m' # White
export unkblk='\e[4;30m' # Black - Underline
export undred='\e[4;31m' # Red
export undgrn='\e[4;32m' # Green
export undylw='\e[4;33m' # Yellow
export undblu='\e[4;34m' # Blue
export undpur='\e[4;35m' # Purple
export undcyn='\e[4;36m' # Cyan
export undwht='\e[4;37m' # White
export bakblk='\e[40m'   # Black - Background
export bakred='\e[41m'   # Red
export badgrn='\e[42m'   # Green
export bakylw='\e[43m'   # Yellow
export bakblu='\e[44m'   # Blue
export bakpur='\e[45m'   # Purple
export bakcyn='\e[46m'   # Cyan
export bakwht='\e[47m'   # White
export txtrst='\e[0m'    # Text Reset

function __cprompt() {
	## http://wiki.archlinux.org/index.php/Color_Bash_Prompt
	#me no understand why promt different escapes for colors? me stupid :(
	local txtblk="\[\033[0;30m\]" # Black - Regular
	local txtred="\[\033[0;31m\]" # Red
	local txtgrn="\[\033[0;32m\]" # Green
	local txtylw="\[\033[0;33m\]" # Yellow
	local txtblu="\[\033[0;34m\]" # Blue
	local txtpur="\[\033[0;35m\]" # Purple
	local txtcyn="\[\033[0;36m\]" # Cyan
	local txtwht="\[\033[0;37m\]" # White
	local bldblk="\[\033[1;30m\]" # Black - Bold
	local bldred="\[\033[1;31m\]" # Red
	local bldgrn="\[\033[1;32m\]" # Green
	local bldylw="\[\033[1;33m\]" # Yellow
	local bldblu="\[\033[1;34m\]" # Blue
	local bldpur="\[\033[1;35m\]" # Purple
	local bldcyn="\[\033[1;36m\]" # Cyan
	local bldwht="\[\033[1;37m\]" # White
	local unkblk="\[\033[4;30m\]" # Black - Underline
	local undred="\[\033[4;31m\]" # Red
	local undgrn="\[\033[4;32m\]" # Green
	local undylw="\[\033[4;33m\]" # Yellow
	local undblu="\[\033[4;34m\]" # Blue
	local undpur="\[\033[4;35m\]" # Purple
	local undcyn="\[\033[4;36m\]" # Cyan
	local undwht="\[\033[4;37m\]" # White
	local bakblk="\[\033[40m\]"   # Black - Background
	local bakred="\[\033[41m\]"   # Red
	local badgrn="\[\033[42m\]"   # Green
	local bakylw="\[\033[43m\]"   # Yellow
	local bakblu="\[\033[44m\]"   # Blue
	local bakpur="\[\033[45m\]"   # Purple
	local bakcyn="\[\033[46m\]"   # Cyan
	local bakwht="\[\033[47m\]"   # White
	local txtrst="\[\033[0m\]"    # Text Reset


	local gitPrompt
	local gitBranch
	gitBranch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
	#echo $?
	if [ $? -eq 0 ]; then
		local gitClean
		local gitStaged
		# ⚙⩲★⚕
		git diff --no-ext-diff --quiet --exit-code 2>/dev/null || gitClean="⚡"
		if git rev-parse --quiet --verify HEAD >/dev/null; then
			git diff-index --cached --quiet HEAD -- || gitStaged="★"
		fi
		
		gitPrompt=" ${txtcyn}[${gitBranch}${bldred}${gitStaged}${bldylw}${gitClean}${txtcyn}]"
	fi
	
	if [ -w . ]; then
		local DIR_COLOR="${bldwht}"
	else
		local DIR_COLOR="${bakylw}${bldblk}"
	fi
	if [ $UID -eq 0 ]; then
		export PS1="${txtwht}[\A]${bldwht}[${bldred}\u${bldwht}@${txtylw}\h${bldwht}:${DIR_COLOR}\w${txtrst}${bldwht}]${gitPrompt}${bldred}#${txtrst} "
	else
		export PS1="${txtwht}[\A]${bldwht}[${txtblu}\u${bldwht}@${txtylw}\h${bldwht}:${DIR_COLOR}\w${txtrst}${bldwht}]${gitPrompt}${txtgrn}\$${txtrst} "
	fi
}


function __prompt_command () {
	__cprompt
	history -a
	#history -c
	#history -r
}

export PROMPT_COMMAND='__prompt_command'


## colors!
alias grep='grep --color=auto'
alias ls='ls --color=auto'
eval $(dircolors -b)
[ -x /usr/bin/colordiff ] && alias diff='colordiff'
[ -x /usr/bin/colorsvn ] && alias svn='/usr/bin/colorsvn'
#[ -x ~/lesspipe.sh ] && export LESSOPEN="|~/lesspipe.sh %s"
export LESS=' -R'
function _less_alias_function () {
	if [ -x /usr/bin/source-highlight ]; then
		case "$1" in
		*ChangeLog|*changelog )
			/usr/bin/source-highlight --failsafe -f esc --lang-def=changelog.lang --style-file=esc.style -i "$1"|less
			;;
		*Makefile|*makefile )
			/usr/bin/source-highlight --failsafe -f esc --lang-def=makefile.lang --style-file=esc.style -i "$1"|less
			;;
		*.[ch]|*.cpp|*.hpp|*.java|*.pl|*.php|*.html|*.xhtml|*.js|*.xml|*.xsl|*.xslt|*.sh|*.bashrc|*.sql|*.patch  )
			source-highlight --failsafe --infer-lang -f esc --style-file=esc.style -i "$1"|less
			;;
		* ) # TODO: check for mimetype with file -ib and use source-highlight too
			if [ -x /usr/bin/lesspipe.sh ]; then
				/usr/bin/lesspipe.sh "$1"|less
			else
				less "$1"
			fi
			;;
		esac
	elif [ -x /usr/bin/lesspipe.sh ]; then
		/usr/bin/lesspipe.sh "$1"|less
	else
		less "$1"
	fi
}
#alias less="_less_alias_function"
## other
alias back='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~="cd ~"


# has stupid extra output
#if [ -x /usr/bin/colortail ]; then
#	alias tail='/usr/bin/colortail '
#fi
#if [ -x /usr/bin/colorgcc ]; then
#	export CC="colorgcc"
#fi


# manpage colors
export LESS_TERMCAP_mb=$(printf "$bldwht")
export LESS_TERMCAP_md=$(printf "$bldblu")
export LESS_TERMCAP_me=$(printf "$txtrst")
export LESS_TERMCAP_se=$(printf "$txtrst")
export LESS_TERMCAP_so=$(printf "\e[1;47;30m")
export LESS_TERMCAP_ue=$(printf "$txtrst")
export LESS_TERMCAP_us=$(printf "$txtcyn")
function env() {
	exec /usr/bin/env "$@" | grep -v ^LESS_TERMCAP_
}

## utility functions
function calc() {
	echo "$*" | bc 
}

function cs() {
	cd "$1"
	ls
}

function ldir () {
	if [ -z "$1" ]; then
		return
	fi
	local i
	local dir
	local dirs=()
	let i=0
	while read dir; do
		if [ -d "$dir" ] && [ -x "$dir" ]; then
			echo -e "$bldwht[$bldred${i}$bldwht]$txtrst $dir"
			dirs[$i]="$dir"
			let i++
		fi
	done < <(locate -b -e -q "$1"|grep -Pv '\/\.'| sort)
	if [ ${#dirs[*]} -eq 1 ]; then
		cs "${dirs[0]}"
	elif [ ${#dirs[*]} -gt 1 ]; then
		echo -n -e "$bldred>>$txtrst "
		local sel
		read sel
		if [ ! -z "${dirs[$sel]}" ]; then
			cs "${dirs[$sel]}"
		fi
	fi
}

#function spam() {
#	curl -s --basic --user "${TUSER}:${TPASSWORD}" --data-urlencode status@- http://twitter.com/statuses/update.xml
#}

# http://pastebin.com/api.php
function pastebin() {
	curl -s --data-urlencode paste_code@- -d paste_name="$USER" -d paste_expire_date=N http://pastebin.com/api_public.php|tail -n 1
	echo
}

#function imagebin() {
#echo "$1"
#	curl -F nickname="$USER" -F image=@"$1" -F title= -F description= -F disclaimer_agree=Y -F Submit=Submit -F mode=add http://imagebin.org/index.php #|grep -P '^Location:'
#	echo
#	#curl --verbose -F name="$USER" -F f=@temp.jpeg   -F sfile=Upload http://imagebin.ca/upload.php
#}


[ -f /etc/arch-release ] && . ~/.bashrc-archlinux
[ -f ~/git-completion.bash ] && . ~/git-completion.bash

