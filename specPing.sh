######################################################

# Actively pings target to determine network proximity

######################################################

tmac=$1 # target mac passed as argument
rand_l=$2 # lower random time - minutes
rand_u=$3 # upper random time - minutes
code=$4 # codename for target

# scan subnet for IP/MAC of target and ping to add to arp table
ping `grep -i $tmac hosts.txt | awk '{print $1}'` -c 3 &> /dev/null

tip=`arp -a | grep $tmac | cut -d "(" -f2 | cut -d ")" -f1` # target ip address

# main loop
while true
do

    time=$(stat -c %Y specInd.txt) # record last modified time on file
    echo $time
    # random number between 20 and 30 min (as seconds) to sleep
    int=$(($rand_l*60+$RANDOM%(($rand_u-$rand_l)*60)))
    echo 'sleep...'
    sleep $int # 25 (sec) for testing

    time2=$(stat -c %Y specInd.txt) # record last modified time on file
    echo $time2

    if [ $(($time2-$time)) -le 2 ]
        then
    	echo 'times are close'
    	echo false > specInd.txt
    	ping $tip -c 3 &> /dev/null
	fi
	
	# send condition to IRC - later
	msg=`head specInd.txt`
	msg=""$code" is neigh: $msg"
	bash send.sh "$msg"
	echo "$msg"
	echo

done
