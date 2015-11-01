##################################################################

# Master script to coordinate other scripts
# Assumes airmon-ng is installed and running on a second interface

##################################################################

# setup interface
echo "Setting up wireless device for monitoring..."
echo
airmon-ng start <second wireless interface> # for interface name - ifconfig

# env variables
mface='<monitor interface name>' # monitor interface name
mac='<target mac>' # target mac
ap='<SSID>' # access point name
code='<codename>' # codename for target
rand_l=20 # lower random time - minutes
rand_u=30 # upper random time - minutes
echo false > specInd.txt # set default value in indictor file

# do while target on network - to get ip address. comment this out after target ip address obtained
arp-scan -I <primary wireless device> -r 3 192.168.1.0/24 > hosts.txt

# run passive python packet monitor
python specProbe.py $mface $mac $ap $code & # manually kill the python process after script is halted

# run active bash pinger
bash specPing.sh $mac $rand_l $rand_u $code &> /dev/null

wait
