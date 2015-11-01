#Network Tracker

These scripts can be used to track a whether network device is on the network. Requires a secondary WiFi device and `airmon-ng`, which is part of the [aircrack-ng](https://github.com/aircrack-ng/aircrack-ng) package, to run.

##Code

`master.sh` sets up the secondary WiFi device in "monitoring mode", sets environmental variables, finds the IP address of the target device, and executes the `specProbe.py` and `specPing.sh` scripts.

`specProbe.py` passively looks for Dot11 probe requests from target device and determines whether a connection is being established or is active. It then logs the data in `log.txt`.

`specPing.sh` actively looks for Dot11 probe requests from target device after pinging it. Also, continuously attempts to ping the device while it's off the network. Findings are reported in the terminal and in an IRC chatroom specified in `master.sh`.

`send.sh` sends message to IRC chatroom on [freenode.net](freenode.net).

##Known Issues

`specProbe.py continues running after `master.sh` is terminated and needs to be killed manually.
