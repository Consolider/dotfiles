#!/bin/sh
#
# Creates 4x10 screen thumbnail of video file.
#
# * Put this file into your home binary dir: ~/bin/ or ~/.config/Thunar/bin/
# * Make it executable: chmod +x
#
#
# Required Software:
# -------------------------
#   * mtn (https://gitlab.com/movie_thumbnailer/mtn)
#
#
# Thunar Integration
# ------------------------
#
#   Command:      ~/.config/Thunar/bin/thunar-create-thumbnail.sh -q %f
#   File Pattern: *
#   Appear On:    Video Files
#
#
# Usage:
# -------------------------
#   thunar-create-thumbnail.sh -q <filename>
#
#     required:
#      -q    input filename
#
# Note:
# -------------------------
#
#


usage() {
	echo "$0 -q <filename>"
	echo
	echo " required:"
	echo "   -q    input filename"
	echo
}


while getopts ":q:" i; do
	case "${i}" in
		q)
			q=${OPTARG}
			;;
		*)
			echo "Error - unrecognized option $1" 1>&2
			usage
			;;
	esac
done
shift $((OPTIND-1))

# Check if file is specified
if [ -z "${q}" ]; then
	echo "Error - no file specified" 1>&2
	usage
	exit 1
fi

# Check if mtn exists
if ! command -v mtn >/dev/null 2>&1 ; then
	echo "Error - 'mtn' not found." 1>&2
	exit 1
fi

$(which mtn) -c 4 -r 10 -w 1200 -g 3 -D 6 -f /usr/share/fonts/FiraCodeNerdFont-Regular.ttf -F ffffff:10:/usr/share/fonts/FiraCodeNerdFont-Regular.ttf:ffffff:000004:8 -h 30 -k 000000 "${q}"
exit $?

