#!/bin/bash
#  _   _                     _     _  __ _            _      _      _        
# | |_(_)_ __ ___   ___  ___| |__ (_)/ _| |_       __| | ___| | ___| |_ ___  
# | __| | '_ ` _ \ / _ \/ __| '_ \| | |_| __|____ / _` |/ _ \ |/ _ \ __/ _ \ 
# | |_| | | | | | |  __/\__ \ | | | |  _| ||_____| (_| |  __/ |  __/ ||  __/ 
#  \__|_|_| |_| |_|\___||___/_| |_|_|_|  \__|     \__,_|\___|_|\___|\__\___| 
#                                                                            
#  
# by Consolider (2024) 
# ----------------------------------------------------- 

sudo timeshift --list > /tmp/timeshift-delete.txt

## If number of snapshots is greater then 7, put the snapshots that are going to be deleted into array
no_snapshots=$(cat /tmp/timeshift-delete.txt | grep arch | wc -l)
no_rows=$((no_snapshots - 7))

if [ $no_snapshots -gt 7 ]; then
    echo "More snaps than 7, deleting old.."
    snapshots=$(cat /tmp/timeshift-delete.txt | grep arch | awk '{ print $3 }' | sed -n "1,${no_rows}p")
    
    for snap in $snapshots; do
        sudo timeshift --delete --snapshot $snap
    done
fi

echo ""
echo "Old snapshot deleted."
echo ""

