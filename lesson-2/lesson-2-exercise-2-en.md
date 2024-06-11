# Lesson 2 - Exercise 2: External Communication using UDP API and the Border Router

## Download following project and open it using the VS code

[thread-udp-example](/lesson-2/thread-udp-example/)

## Sending UDP Packets via API
The goal of this exercise is to send UDP messages when the Nordic board button is pressed.

Reference: [Openthread UDP API](https://openthread.io/reference/group/api-udp?hl=en)

### Configuring the project to automatically connect to the Border Router Thread network
1. Add the following attributes to the `prj.conf` file to enable thread communication:
    ```conf
    # Enable OpenThread features set
    CONFIG_OPENTHREAD_NORDIC_LIBRARY_MASTER=y
    CONFIG_NET_L2_OPENTHREAD=y

    # Generic networking options
    CONFIG_NETWORKING=y
    CONFIG_NET_UDP=y
    CONFIG_MBEDTLS_SHA1_C=n
    CONFIG_FPU=y

    CONFIG_OPENTHREAD_MANUAL_START=n
    CONFIG_OPENTHREAD_NETWORK_NAME="OpenThreadUfes"
    # 4660 (decimal base) is equal to 0x1234 (hexadecimal base)
    CONFIG_OPENTHREAD_PANID=4660
    CONFIG_OPENTHREAD_XPANID="11:11:11:11:22:22:22:22"
    CONFIG_OPENTHREAD_NETWORKKEY="00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff"
    CONFIG_OPENTHREAD_CHANNEL=11
    ```

### Configuring the UDP API
1. Add the following includes to your project's `main.c` file:
    ```C
    #include <zephyr/net/openthread.h>
    #include <openthread/thread.h>
    #include <openthread/udp.h> 
    ```
1. Add the following global variable:
    ```C
    otInstance *myInstance;
    otUdpSocket mySocket;
    ```

1. Adicione a seguinte função no arquivo `main.c` do seu projeto
    
    Change the IP of line `otIp6AddressFromString("fd23:fd03:a39d:2:0:0::192.168.0.162", &messageInfo.mPeerAddr);` to the IP your receiver (smartphone or laptop)
    
    note: `fd23:fd03:a39d:2:0:0::` is the prefix and `192.168.0.162` is the IPv4
    
    ```C
    static void udp_send(void) 
    {
        otError error = OT_ERROR_NONE;
        //Setting the UDP message
        const char *buf = "Hello Thread xd"; 

            //Setting receiver device port and IP
        otMessageInfo messageInfo;
        memset(&messageInfo, 0, sizeof(messageInfo)); 
        otIp6AddressFromString("fd23:fd03:a39d:2:0:0::192.168.0.162", &messageInfo.mPeerAddr); // receiver device IP
        messageInfo.mPeerPort = 1234; // receiver device UDP port


        // Setting the UDP message
        otMessage *test_Message = otUdpNewMessage(myInstance, NULL);
        error = otMessageAppend(test_Message, buf, (uint16_t)strlen(buf));
        if (error != OT_ERROR_NONE){
            printk("otMessageAppend error: %d\n", error);
            return;
        }

        // Sending UDP package
        error = otUdpSend(myInstance, &mySocket, test_Message, &messageInfo);
        if (error != OT_ERROR_NONE){
            printk("otUdpSend error: %d\n", error);
            return;
        }


        printk("Sent.\n");
    }
    ```
    
1. Add the udp init function
    ```C
    // initializing UDP receiver
    static void udp_init(void)
    {
        otError error = OT_ERROR_NONE;

        // Getting openthread instance
        myInstance = openthread_get_default_instance();

        // Opening UDP socket with a callback fucntion
        error = otUdpOpen(myInstance, &mySocket, udp_receiver_cb, NULL); 
        if (error != OT_ERROR_NONE){
            printk("otUdpOpen error: %d\n", error);
            return;
        }

        printk("init_udp success\n");
    }
    ```

1. Add the `udp_send()` function to the callback function that will be called when the board button is pressed
    ```C
    void button_pressed(const struct device *dev, struct gpio_callback *cb, uint32_t pins)
    {
        printk("Seding...");
        udp_send();
    }
    ``` 

1. Call the UDP initialization function at the end of your project's `main()` function

    ```C
    void main(void)
    {
        //other codes
        ...
        udp_init();
    }
    ```

Note: use your smartphone to receive the UDP message as in exercise 1, or download [UDP Test Tool 3.0](https://udp-test-tool.informer.com/) for Windows

### Checking thread connection

2. Check the IPs printed in the serial terminal :

    ```bash
    (1) IPv6 Address origin = OT_ADDRESS_ORIGIN_SLAAC, valid = 1: fd23:fd03:a39d:0001:5fac:21a7:e466:2185

    (2) IPv6 Address origin = OT_ADDRESS_ORIGIN_THREAD, valid = 1: fdd5:caf7:96f6:d594:0000:00ff:fe00:cc00

    (3) IPv6 Address origin = OT_ADDRESS_ORIGIN_THREAD, valid = 1: fdd5:caf7:96f6:d594:f050:3a6e:dcf5:5258

    (4) IPv6 Address origin = OT_ADDRESS_ORIGIN_THREAD, valid = 1: fe80:0000:0000:0000:5c54:1cc4:d3f0:0c27
    ```
The OT_ADDRESS_ORIGIN_SLAAC will be your communication IP

## Receiving UDP packets via API
1. Add the following UDP callback function to the `main.c` file of your project
    ```C
    //UDP callback function
    void udp_receiver_cb(void *aContext, otMessage *aMessage, const otMessageInfo *aMessageInfo)
    {
        // Calculating the payload length of the received message
        uint16_t payloadLength = otMessageGetLength(aMessage) - otMessageGetOffset(aMessage);
        
        // Creating and allocating receiver buffer memory
        char *buf;
        buf = (char *) malloc(payloadLength);
        
        // Coping the message for the created buf variable
        otMessageRead(aMessage, otMessageGetOffset(aMessage), buf, payloadLength);
        
        // Setting the end of string
        buf[payloadLength] = '\0';
        
        // Printing the received information
        printk("Received: %s\n",buf);

        // Deallocate buffer memory
        free(buf);
    }
    ```

1. Add the following codes to the end of `udp_init()` function in your project's `main.c` file

    ```C
    // initializing UDP receiver
    static void udp_init(void)
    {
        //other codes.....
        
        // Setting the port to listening 
        otSockAddr mySockAddr;
        memset(&mySockAddr,0,sizeof(mySockAddr));
        mySockAddr.mPort = 1234;

        // Binding UDP port to receiver UDP package
        error = otUdpBind(myInstance, &mySocket, &mySockAddr, OT_NETIF_THREAD);
        if (error != OT_ERROR_NONE){
            printk("otUdpBind error: %d\n", error);
            return;
        }

        printk("init_udp success\n");
    }
    ```

Note: use your smartphone to send the UDP message as in Exercise 1

## Controlling an LED via UDP packets

### Configuring LED control
Follow step-by-step described in Lesson 2 - Exercise 1 of [nRF Connect SDK Fundamentals](https://academy.nordicsemi.com/courses/nrf-connect-sdk-fundamentals/lessons/lesson-2-reading-buttons-and -controlling-leds/topic/exercise-1-2/)

### Protocolo simplificado

1. Protocolo para Ligar e desligar o LED

    1. Para ligar o LED, deve-se enviar o caracter `'1'` no payload do pacote UDP

    1. Para ligar o LED, deve-se enviar o caracter `'0'` no payload do pacote UDP

1. Adicione os seguinte códigos a função de callback `udp_receiver_cb()` para controlar o LED
    ```C
    //checking for LED commands
	if(strcmp(buf, "1") == 0){
		// Turning on the LED
		printk("Turning on the LED\n");
		gpio_pin_set_dt(&led, 1);
	}else if(strcmp(buf, "0") == 0){
		// Turning off the LED
		printk("Turning off the LED\n");
		gpio_pin_set_dt(&led, 0);
	}
    ```
### CHALLENGE I: Let's go create a more elaborate protocol?

#### Let's control the RGB LED colors separately

1. Protocol:

    ```
    <id_led>,<status_LED>
    ``` 

2. id_led represents the LED color identification
    ```
    '1' -> LED Red
    '2' -> LED Green
    '3' -> LED Blue
    ```

2. status_LED defines the LED state
    ```
    '1' -> LED ligado
    '2' -> LED desligado
    ```
1. Examples
    1. Tuning on the red LED
        ```
            payload do pacote UDP será "1,1"
        ```  
    1. Tuning off the red LED
        ```
            payload do pacote UDP será "1,0"
        ```  
    1. Tuning on the gree LED
        ```
            payload do pacote UDP será "2,1"
        ``` 
    1. Tuning off the red LED
        ```
            payload do pacote UDP será "3,0"
        ```      

#### Let's control all the colors using just one request

1. Protocol:
    
    ```
    <status_LED_RED>,<status_LED_GREEN>,<status_LED_BLUE>
    ``` 

1. Exemplos
    1. Tuning on the red, green and blue LED
        ```
        payload do pacote UDP será "1,1,1"
        ```  
    1. Tuning off the red, green and blue LED
        ```
            payload do pacote UDP será "0,0,0"
        ```  
    1. Tuning on the red and green LED and Tuning off the blue LED
        ```
            payload do pacote UDP será "1,1,0"
        ``` 


