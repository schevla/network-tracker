from scapy.all import *
from datetime import datetime
import sys
import os

# preprare log file
f=open('log.txt','w')
f.write('Start: ' + str(datetime.now())[11:22] + '\n\n')

# env variables
mface=sys.argv[1] # monitor interface name
mac=sys.argv[2] # target mac
ap=sys.argv[3] # access point name
code=sys.argv[4] # codename for target

def pktPrint(pkt):

    # passive check for probes from target
    if pkt.haslayer(Dot11ProbeReq):
        if pkt.addr2 == mac:
	    # non-connected probe
            if pkt.getlayer(Dot11ProbeReq).info == ap:
                print '[' + str(datetime.now())[11:22] + '] ' + code + ' has begun'
                f.write('[' + str(datetime.now())[11:22] + '] ' + code + ' has begun\n')
		os.system("echo true > specInd.txt")
            # connected probe
	    else:
                print '[' + str(datetime.now())[11:22] + '] ' + code + ' is neigh'
                f.write('[' + str(datetime.now())[11:22] + '] ' + code + ' is neigh\n')
		os.system("echo true > specInd.txt")

    # active check for target in range
    if pkt.haslayer(ICMP):
	if pkt.src == mac:
	    print '[' + str(datetime.now())[11:22] + '] ' + code + ' check in'
	    f.write('[' + str(datetime.now())[11:22] + '] ' + code + ' check in\n')
	    os.system("echo true > specInd.txt")

conf.iface=mface
sniff(prn=pktPrint)

f.write('\nFinish: ' + str(datetime.now())[11:22])
f.close()
