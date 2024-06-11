
## Lesson 2 - Exercise 1: External communication using Border Router

## Connecting the Thread network of the border router
1. Resetting to factory settings
    ```bash
    > ot factoryreset
    ```
1. Stopping the default thread network
    ```bash
    > ot thread stop
    Done
    ```

1. Changing the panid to joiner mode
    ```bash
    > ot panid 0xffff
    ```
2. Starting the Joiner
    ```bash
    > ot ifconfig up
    Done
    > ot joiner start 123456
    Done
    Join success
    ```
1. Starting the Thread service for connection
     ```bash
     > ot thread start
    Done
     ```
3. Validating the expected Thread network data after connection

    ```bash
    > ot dataset active
    Active Timestamp: 1
    Channel: 11
    Channel Mask: 0x07fff800
    Ext PAN ID: 39758ec8144b07fb
    Mesh Local Prefix: fdf1:f1ad:d079:7dc0::/64
    Network Key: 00112233445566778899aabbccddeeff
    Network Name: OpenThreadUfes
    PAN ID: 0x1234
    PSKc: 3ca67c969efb0d0c74a4d8ee923b576c
    Security Policy: 672 onrc 0
    Done
    ```

## Sending external ping

### Sending ping to google.com

1. Open the command prompt on **your computer** and type the following command to find out the IP of google, as the board's `ping` command does not perform the DNS service
    ```bash
    > ping google.com
    Pinging google.com [XXX.XXX.XXX.XXX] with 32 bytes of data:
    Reply from XXX.XXX.XXX.XXX: bytes=32 time=22ms TTL=118
    Reply from XXX.XXX.XXX.XXX: bytes=32 time=27ms TTL=118
    Reply from XXX.XXX.XXX.XXX: bytes=32 time=22ms TTL=118
    ....
    ```
2. Sending a ping to google.com from the Thread network using the IP from the previous step
    ```bash
    > ot ping XXX.XXX.XXX.XXX
    Pinging synthesized IPv6 address: xxxx:xxxx:xxxx:x:x:x:xxxx:xxxx
    16 bytes from xxxx:xxxx:xxxx:x:x:x:xxxx:xxxx: icmp_seq=1 hlim=117 time=80ms
    1 packets transmitted, 1 packets received. Packet loss = 0.0%. Round-trip min/avg/max = 80/80.0/80 ms.
    Done
    ```

    note that google's IP is v4 and was converted to v6

## Receiving UDP packets from the external network

### Preparing the Nordic board to receive packets
1. Enabling the UDP socket
    ```bash
    > ot udp open
    Done
    ```
1. Binding a UDP socket listener port

    Command: `bind [netif] <ip> <port>`

    ``` bash
    > ot udp bind :: 1234
    Done
    ```

    The symbol `::` indicates that the IPv6 address is unspecified, meaning packets from any IPv6 are accepted.

### Preparing the Android smartphone to send packets
1. Discovering the global IPv6 of the Nordic board on the Thread network
    ```bash
    > ot ipaddr -v
    fd11:22:0:0:7046:8b7c:fe3d:81bd origin:slaac
    fd8d:1d8a:2936:e08c:0:ff:fe00:b000 origin:thread
    fd8d:1d8a:2936:e08c:bd0a:8f97:714c:557f origin:thread
    fe80:0:0:0:102b:117c:e47:5aeb origin:thread
    Done
    ```
    The IP with `origin:slaac` at the end is the global IP (external to the Thread network)

2. Download the test application and send a message to the IP discovered in the previous step and the configured port (1234)

    [UDP terminal](https://play.google.com/store/apps/details?id=com.hardcodedjoy.udpterminal&hl=en_US)

1. Adjust the **Remote IP** and **Remote Port** to the IP and port (1234) of the board in the APP settings
    <p align="center">
    <img src="https://play-lh.googleusercontent.com/DY-aqauXDmnVvcbTgL-O15beDP5g98k9bI758ZuvU5_WJ6-BldxbBHIcu_61wCLcLmQ=w2560-h1440-rw" width="200" title="hover text">
    <p>

## Sending external UDP packets

1. In the application from the previous step, enable the `local echo` function to receive messages from the Nordic board and set `Local Port` to 1234

1. Sending a UDP message from the Nordic board, where you need to fill in the smartphone's IP and the chosen port in the settings

    Command: `udp send <ip> <port> <type> <value>`

    ```bash
    > ot udp send 192.168.0.162 1234 hello
    Done
    ```
