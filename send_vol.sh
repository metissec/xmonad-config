vol=$(amixer sget Master | awk -F'[]%[]' '/%/ {if ($7 == "off") { print "0" } else { print $2}}')
echo ${vol}% | tee /tmp/.volume-pipe
exit 0
