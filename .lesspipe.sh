#!/bin/bash

if [ -x /usr/bin/source-highlight ]; then
	case "$1" in
	*ChangeLog|*changelog )
		/usr/bin/source-highlight --failsafe -f esc --lang-def=changelog.lang --style-file=esc.style -i "$1"
		;;
	*Makefile|*makefile )
		/usr/bin/source-highlight --failsafe -f esc --lang-def=makefile.lang --style-file=esc.style -i "$1"
		;;
	*.[ch]|*.cpp|*.hpp|*.java|*.pl|*.php|*.html|*.xhtml|*.js|*.xml|*.xsl|*.xslt|*.sh|*.bashrc|*.sql|*.patch  )
		source-highlight --failsafe --infer-lang -f esc --style-file=esc.style -i "$1"
		;;
	* ) if [ -x /usr/bin/lesspipe.sh ]; then
			/usr/bin/lesspipe.sh "$1"
		else
			cat "$1"
		fi
		;;
	esac
elif [ -x /usr/bin/lesspipe.sh ]; then
	/usr/bin/lesspipe.sh "$1"
else
	cat "$1"
fi
