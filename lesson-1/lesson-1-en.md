# Lesson 1: Openthread CLI commands
The CLI commands in this lesson are executed using the example of [Nordic openthread CLI](https://developer.nordicsemi.com/nRF_Connect_SDK/doc/latest/nrf/samples/openthread/cli/README.html).

If your device is a **nRF52840 dongle**, add the **overlay-usb.conf** to kconfig fragments and the **usb.overlay** to the device tree overlay to enable USB communication.

## Setting up a Thread network
1. Disabling the Thread interface
    ```bash
    > ot ifconfig down
    Done
    > ot thread stop
    Done
    ```

1. Creating new configuration for the network
    ```bash
    > ot dataset init new
    Done
    ```

2. Printing the the generated configurations
    ```bash
    > ot dataset
    Active Timestamp: 1
    Channel: 15
    Channel Mask: 0x07fff800
    Ext PAN ID: 39758ec8144b07fb
    Mesh Local Prefix: fdf1:f1ad:d079:7dc0::/64
    Network Key: f366cec7a446bab978d90d27abe38f23
    Network Name: OpenThread-5938
    PAN ID: 0x5938
    PSKc: 3ca67c969efb0d0c74a4d8ee923b576c
    Security Policy: 672 onrc 0
    Done
    ```

3. Changing the network name (optional)
    ```bash
    > ot dataset networkname openthread-ufes
    Done
    ```

4. Changing the network key (optional)
    ```bash
    > ot dataset networkkey 00112233445566778899aabbccddeeff
    Done
    ```
5. Changing the network panid (optional)
    ```bash
    > ot dataset panid 0x1234
    Done
    ```

6. Changing the network channel (optional)
    ```bash
    > ot dataset channel 11
    Done
    ```
1. Saving the new settings

    ```bash
    > ot dataset commit active
    Done
    ```

1. Enabling the Thread interface

    ```bash
    > ot ifconfig up
    Done
    > ot thread start
    Done
    ```
To modify other attributes, read more at [dataset](https://github.com/openthread/openthread/blob/main/src/cli/README_DATASET.md)

## Scanning Threads networks
1. Checking available Thread networks by using `discover` command
    
    command: `discover [channel]`
    
    ```bash
    > ot discover
    | J | Network Name     | Extended PAN     | PAN  | MAC Address      | Ch | dBm | LQI |
    +---+------------------+------------------+------+------------------+----+-----+-----+
    | 0 | OpenThread       | dead00beef00cafe | ffff | f1d92a82c8d8fe43 | 11 | -20 |   0 |
    Done
    ```
1. Checking available Thread networks by using `scan` command

    Comando: `scan [channel]`
    
    ```bash
    > ot scan
    | PAN  | MAC Address      | Ch | dBm | LQI |
    +------+------------------+----+-----+-----+
    | ffff | f1d92a82c8d8fe43 | 11 | -20 |   0 |
    Done
    ```

## Connecting to an existing Thread network

### Via commissioning
Reference [OpenThread CLI - Commissioning](https://github.com/openthread/openthread/blob/main/src/cli/README_COMMISSIONING.md)

#### Starting the commissioning session
Execute the following steps on the device that is alread connected to a Thread network.

1. Enabling the commissioner role 
    ```bash
    > ot commissioner start
    Commissioner: petitioning
    Done
    Commissioner: active
    ```

2. Adding a commissioning session

    command: `commissioner joiner add <eui64>|<discerner> <pskd> [timeout]`

    Adding a Joiner

    - eui64: the IEEE EUI-64 of the Joiner or '\*' to match any Joiner
    - discerner: the Joiner discerner in format `number/length`
    - pskd: pre-Shared Key for the Joiner
    - timeout: joiner timeout in seconds

    ```bash
    > ot commissioner joiner add * J01NME 10000
    Done
    ```

3. Checking the joiner table
    ```bash
    > ot commissioner joiner table
    | ID                    | PSKd                             | Expiration |
    +-----------------------+----------------------------------+------------+
    |                     * |                           J01NME |      81015 |
    |      d45e64fa83f81cf7 |                           J01NME |     101204 |
    | 0x0000000000000abc/12 |                           J01NME |     114360 |
    Done
    ```
#### Starting the commissioning process
Execute the following steps on the device that will connect to the Thread network.


1. Resetting to factory settings
    ```bash
    > ot factoryreset
    ```
1. Stopping the default Thread network
    ```bash
    > ot thread stop
    Done
    ```

1. Setting the panid to joiner mode
    ```bash
    > ot panid 0xffff
    ```
2. Starting the Joiner
    ```bash
    > ot ifconfig up
    Done
    > ot joiner start J01NME
    Done
    Join success
    ```
1. Starting the Thread service
     ```bash
     > ot thread start
    Done
     ```
3. Validating the expected Thread network configuration after connection

    ```bash
    > ot dataset active
    Active Timestamp: 1
    Channel: 11
    Channel Mask: 0x07fff800
    Ext PAN ID: 39758ec8144b07fb
    Mesh Local Prefix: fdf1:f1ad:d079:7dc0::/64
    Network Key: 00112233445566778899aabbccddeeff
    Network Name: openThread-ufes
    PAN ID: 0x1234
    PSKc: 3ca67c969efb0d0c74a4d8ee923b576c
    Security Policy: 672 onrc 0
    Done
    ```

### Via networkkey
In this case, only the networkkey is required for a device to connect to a Thread network.

1. Resetting to factory settings
    ```bash
    > ot factoryreset
    ```

1. Disabling Thread interface
    ```bash
    > ot ifconfig down
    Done
    > ot thread stop
    Done
    ```

1. Creating a partial configuration in the active dataset
    ```bash
    > ot dataset networkkey 00112233445566778899aabbccddeeff
    Done
    ```

1. Adding the channel (optional)
    Although not required, specifying the channel avoids the need to search multiple channels, improving the latency and efficiency of the connection process.
    ```bash
    > ot dataset channel 11
    Done
    ```

1. Saving the new settings

    ```bash
    > ot dataset commit active
    Done
    ```

1. Enabling Thread interface

    ```bash
    > ot ifconfig up
    Done
    > ot thread start
    Done
    ```

3. Validating expected Thread network configuration after connection

    ```bash
    > ot dataset active
    Active Timestamp: 1
    Channel: 18
    Channel Mask: 0x07fff800
    Ext PAN ID: 4989529933386222
    Mesh Local Prefix: fd83:c7ab:e96a:cd01::/64
    Network Key: 00112233445566778899aabbccddeeff
    Network Name: openthread-ufes
    PAN ID: 0xfc1f
    PSKc: 0ba47acf76641f2d082ee454739506cd
    Security Policy: 672 onrc
    Done
    ```


## Configuring a Router on an End Device
1. Checking the device status
    ```bash
    > ot state
    router
    Done
    ```
1. Checking the current state of router mode
    ```bash
    > ot routereligible
    Enabled
    Done
    ```
1. Disabling the router mode
    ```bash
    > ot routereligible disable
    Done
    ```
1. Checking the device new status
    ```bash
    > ot state
    child
    Done
    ```
## Checking connection using Ping
1. Finding the Thread Mesh Local EID address to ping
    ```bash
    > ot ipaddr mleid
    fd83:c7ab:e96a:cd01:3fff:97e0:e6f7:b9d6
    Done
    ```
2. Executing the ping command
    ```bash
    > ot ping fd83:c7ab:e96a:cd01:3fff:97e0:e6f7:b9d6
    16 bytes from fd83:c7ab:e96a:cd01:0:ff:fe00:fc00: icmp_seq=1 hlim=64 time=11ms
    1 packets transmitted, 1 packets received. Packet loss = 0.0%. Round-trip min/avg/max = 11/11.0/11 ms.uart
    ```

## Sending UDP packets

### Sharing you IPv6
1. Print your IPs
    ```bash
    > ot ipaddr -v
    fdc7:a0c4:c9aa:b6b4:0:ff:fe00:f403 origin:thread plen:64 preferred:0 valid:1
    fdc7:a0c4:c9aa:b6b4:39b7:42c5:cb4c:a0aa origin:thread plen:64 preferred:0 valid:1
    fe80:0:0:0:e86a:3f2b:8cc0:4bf0 origin:thread plen:64 preferred:1 valid:1
    Done
    ```
2. Select the first IPv6 and share it on the following link

    [Link to shared your device IP](https://docs.google.com/document/d/1vyUV47gHinF-xTYLZZwq0btTZh-BhY7RQ0jhlOCcDsQ/edit?usp=sharing) 

### Receiver device
1. Enabling UDP socket
    ```bash
    > ot udp open
    Done
    ```
1. Binding a UDP socket listener port

    Comando: `bind [netif] <ip> <port>`

    ``` bash
    > ot udp bind :: 1234
    Done
    ```

    The `::` symbol determines that the IPv6 address is not specified, which means that any packets from IPv6 will be accepted.

### Transmitting device
1. Enabling UDP socket
    ```bash
    > ot udp open
    Done
    ```
1. Sending a Hello message

    command: `udp send <ip> <port> <type> <value>`

    ```bash
    > ot udp send fdde:ad00:beef:0:bb1:ebd6:ad10:f33 1234 hello
    Done
    ```

    Note: remember to add the IP of the receiver device

### Terminating UDP socket
```bash
> ot udp close
Done
```
    

