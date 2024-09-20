#/bin/bash
#        _            _ _             _                                        
#  _   _| |_       __| | |_ __       | |_ ___  _ __ _ __  _ __ _____  ___   _  
# | | | | __|____ / _` | | '_ \ _____| __/ _ \| '__| '_ \| '__/ _ \ \/ / | | | 
# | |_| | ||_____| (_| | | |_) |_____| || (_) | |  | |_) | | | (_) >  <| |_| | 
#  \__, |\__|     \__,_|_| .__/       \__\___/|_|  | .__/|_|  \___/_/\_\\__, | 
#  |___/                 |_|                       |_|                  |___/  
#  
# by Consolider (2024) 
# ----------------------------------------------------- 

SOURCE=~/.scripts

### Include trybatch.sh as a library
source $SOURCE/trycatch.sh

### Define custom exception types
export ERR_BAD_A=1
export ERR_BAD_V=1
export ERR_WORSE=1
export ERR_CRITICAL=102


###--- REQUIREMENT ---###
# curl
# yt-dlp
# tor/torsocks


###--- INVIDEOUS INSTANCES ---###
# https://docs.invidious.io/instances/#list-of-public-invidious-instances-sorted-from-oldest-to-newest
TURLARRAY=(
http://ng27owmagn5amdm7l5s3rsqxwscl5ynppnis5dqcasogkyxcfqn7psid.onion
http://nerdvpneaggggfdiurknszkbmhvjndks5z5k3g5yp4nhphflh3n3boad.onion
)
CURLARRAY=(
https://yewtu.be
https://inv.nadeko.net
https://invidious.nerdvpn.de
https://iv.ggtyler.dev
https://invidious.jing.rocks
https://invidious.perennialte.ch
https://invidious.reallyaweso.me
https://invidious.privacyredirect.com
https://invidious.einfachzocken.eu
https://inv.tux.pizza
https://iv.nboeck.de
https://iv.nowhere.moe
https://invidious.adminforge.de
)


###--- VARIABLES ---###
DESTINATION=~/Downloads/vids
RANTURL=$(printf "%s\n" "${TURLARRAY[@]}" | shuf -n 1)
RANCURL=$(printf "%s\n" "${CURLARRAY[@]}" | shuf -n 1)
OUTPUT='%(uploader)s[%(upload_date)s]%(title)s.%(ext)s'
PROXY='--proxy socks5h://127.0.0.1:9150'
AF='140/ba[ext=m4a]'
VF='bv[ext=mp4][height<=1080]+140/ba'

cd $DESTINATION

read -p "Paste Watch ID (ex. /watch?v=abcdefghij) :" WATCH

try
(
while true; do
    read -p "Video or only Audio? (v/a) (n=break) :" va
    case $va in
        [Vv]* )
            echo "Downloading Video..."
            echo $RANTURL
            yt-dlp $PROXY -f $VF $RANTURL$WATCH -o $OUTPUT || throw $ERR_BAD_V
        break;;
        [Aa]* )
            echo "Downloading Audio..."
            yt-dlp $PROXY -f $AF $RANTURL$WATCH -o $OUTPUT || throw $ERR_BAD_A
        break;;
        [Nn]* )
            echo "Exiting..."
            exit;
        break;;
        * ) echo "Please answer v or a.";;
    esac
done
)
catch || {
    case $exception_code in
        $ERR_BAD_V)
            echo "
            Tor onionaddress couldn't be used, trying Clearlink..."
            try
            (
                yt-dlp $PROXY -f $VF $RANCURL$WATCH -o $OUTPUT || throw $ERR_WORSE
            )
            catch || {
                case $exception_code in
                    $ERR_WORSE)
                        echo "
                        Torproxy & clearlink failed."
                    ;;
                    *)
                        echo "
                        Unknown error: $exit_code"
                        throw $exit_code    # re-throw an unhandled exception
                    ;;
                esac
            }
        ;;
        $ERR_BAD_A)
            echo "
            Tor onionaddress couldn't be used, trying Clearlink..."
            try
            (
                yt-dlp $PROXY -f $AF $RANCURL$WATCH -o $OUTPUT || throw $ERR_WORSE
            )
            catch || {
                case $exception_code in
                    $ERR_WORSE)
                        echo "
                        Torproxy & clearlink failed."
                    ;;
                    *)
                        echo "
                        Unknown error: $exit_code"
                        throw $exit_code    # re-throw an unhandled exception
                    ;;
                esac
            }
        ;;
        *)
            echo "
            Unknown error: $exit_code"
            throw $exit_code    # re-throw an unhandled exception
        ;;
    esac
}

echo "
Complete!"

