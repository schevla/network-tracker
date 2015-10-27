##########################################################

# Ensure gnu-netcat is installed before use
# Use with second argument (message) specified in-ternimal

##########################################################

serv=irc.freenode.net # irc server
port=6667
usr=<username> # simplified - username, hostname, servername, realname
nic=<nicname>
cha=<chatroom>
msg=$1 # piped from stdout (e.g. bash send.sh <yourmessage here>)

# send private message over IRC - output silenced
echo -e "USER $usr $usr $usr $usr\nNICK $nic\nJOIN $cha\nPRIVMSG $cha :$msg\nQUIT" | nc $serv $port &> /dev/null
