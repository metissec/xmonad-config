essid=$(iwconfig wlp1s0 | awk '/IEE/{print $4}' | awk -F\" '{print $2}')
signal=$(iwconfig wlp1s0 | awk '/Link/{print $2}' | awk -F\= '{print $2}' | awk -F\/ '{print int(($1/$2)*100)}' )
if [[ $essid = "" ]]; then
    echo "No Wifi"
else
    echo $essid $signal%
fi

exit 0
