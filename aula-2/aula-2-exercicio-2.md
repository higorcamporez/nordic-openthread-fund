# Aula 2 - Exercício 2: Comunicação externa usando Border Router
Use o projeto o [Nordic openthread CLI](https://developer.nordicsemi.com/nRF_Connect_SDK/doc/latest/nrf/samples/openthread/cli/README.html) como base para esse exercicio

# Confgurando o projeto para se conectar automaticamente a rede Thread do border router
1. Adicione, ou altere caso exita, os seguinte atributos ao `prj.conf`
    ```conf
    CONFIG_PENTHREAD_MANUAL_START=n
    CONFIG_OPENTHREAD_NETWORK_NAME="OpenThreadUfes"
    #4660 (decimal base) is equal to 0x1234 (hexadecimal base)
    CONFIG_OPENTHREAD_PANID=4660
    CONFIG_OPENTHREAD_XPANID="11:11:11:11:22:22:22:22"
    CONFIG_OPENTHREAD_NETWORKKEY="00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff"
    CONFIG_OPENTHREAD_CHANNEL=15
    ```

3. Validando os dados esperados da rede Thread após conexão

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

# Enviando pacotes UDP via API
O objetivo desta está do exercio é enviar uma mensagem UDP ao aperta o botão da placa nordic

Referência [Openthread UDP API](https://openthread.io/reference/group/api-udp?hl=en)

## Configurando o botão como interrupção
Siga a passo a passo do Aula 2 - exercicio 2 do [nRF Connect SDK Fundamentals](https://academy.nordicsemi.com/courses/nrf-connect-sdk-fundamentals/lessons/lesson-2-reading-buttons-and-controlling-leds/topic/exercise-2-3/)

## Configurando a API UDP 
1. Adicione os seguintes includes no arquivo `main.c` do seu projeto
    ```C
    #include <zephyr/net/openthread.h>
    #include <openthread/thread.h>
    #include <openthread/udp.h> 
    ```
1. Adicione a seguinte variável global
    ```C
    otUdpSocket mySocket;
    ```
1. Adicione a seguinte função no arquivo `main.c` do seu projeto
    
    Troque o IP na linha `otIp6AddressFromString("fdfd:d7e3:ff4c:2:0:0::192.168.0.162", &messageInfo.mPeerAddr);` para o IP do seu dispositivo receptor (smartphone ou computador)
    
    Obs: `fdfd:d7e3:ff4c:2:0:0::` é o préfixo e `192.168.0.162` é IPv4
    
    ```C
    static void udp_send(void) 
    {
        otError error = OT_ERROR_NONE;
        //Setting the UDP message
        const char *buf = "Hello Thread xd"; 

        // getting openthread instance
        otInstance *myInstance; 
        myInstance = openthread_get_default_instance();

        // defining UDP socket
        otUdpSocket mySocket; 

        //Setting receiver device port and IP
        otMessageInfo messageInfo;
        memset(&messageInfo, 0, sizeof(messageInfo)); 
        otIp6AddressFromString("fdfd:d7e3:ff4c:2:0:0::192.168.0.162", &messageInfo.mPeerAddr); // receiver device IP
        messageInfo.mPeerPort = 1234; // receiver device UDP port

        // Opening UDP socket
        error = otUdpOpen(myInstance, &mySocket, NULL, NULL);
        if (error != OT_ERROR_NONE){
            printk("otUdpOpen error: %d\n", error);
            return;
        } 

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

        // closing UDP socket
        error = otUdpClose(myInstance, &mySocket);
        if (error != OT_ERROR_NONE){
            printk("otUdpClose error: %d\n", error);
            return;
        }	

        printk("Sent.\n");
    }
    ```
1. Adicione a função `udp_send()` a callback function que será chamada quando o botão for precionado criado anteriomente 
    ```C
    void your_callback_function(const struct device *dev, struct gpio_callback *cb, uint32_t pins)
    {
        printk("Seding...");
        udp_send();
    }
    ``` 
Obs: use o smartphone ou computador para receber a mensagem UDP como no exercicio 1

# Recebendo pacotes UDP via API
1. Adicione a seguinte função de UDP callback ao arquivo `main.c` do seu projeto
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

1. Adicione a seguinte função para inicializar o receptor UDP ao arquivo `main.c` do seu projeto

    ```C
    // initializing UDP receiver
    static void udp_init(void)
    {
        otError error = OT_ERROR_NONE;

        // Getting openthread instance
        otInstance *myInstance = openthread_get_default_instance();
        
        // Setting the port to listening 
        otSockAddr mySockAddr;
        memset(&mySockAddr,0,sizeof(mySockAddr));
        mySockAddr.mPort = 1234;

        // Opening UDP socket with a callback fucntion
        error = otUdpOpen(myInstance, &mySocket, udp_receiver_cb, NULL); 
        if (error != OT_ERROR_NONE){
            printk("otUdpOpen error: %d\n", error);
            return;
        }

        // Binding UDP port to receiver UDP package
        error = otUdpBind(myInstance, &mySocket, &mySockAddr, OT_NETIF_THREAD);
        if (error != OT_ERROR_NONE){
            printk("otUdpBind error: %d\n", error);
            return;
        }

        printk("init_udp success\n");
    }
    ```

1. Chame a a função de inicialização do receptor UDP no final da função `main()` do seu projeto

    ```C
    void main(void)
    {
        //other codes
        ...
        udp_init();
    }
    ```

# Controlando um LED via pacotes UDP

## Configurando o LED
Siga a passo a passo do Aula 2 - exercicio 1 do [nRF Connect SDK Fundamentals](https://academy.nordicsemi.com/courses/nrf-connect-sdk-fundamentals/lessons/lesson-2-reading-buttons-and-controlling-leds/topic/exercise-1-2/)

## Protocolo simplificado

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
## DESAFIO I: Vamos criar um protocolo mais elaborado?

### Vamos controlar as cores do LED RGB separadamente

1. Protocolo:

    ```
    <id_led>,<status_LED>
    ``` 

2. id_led como um identificador da cor do LED
    ```
    '1' -> LED Red
    '2' -> LED Green
    '3' -> LED Blue
    ```

2. status_LED determina o estado do LED:
    ```
    '1' -> LED ligado
    '2' -> LED desligado
    ```
1. Exemplos
    1. Ligando LED red
        ```
            payload do pacote UDP será "1,1"
        ```  
    1. Desligando LED red
        ```
            payload do pacote UDP será "1,0"
        ```  
    1. Ligando LED green
        ```
            payload do pacote UDP será "2,1"
        ``` 
    1. Desligando LED blue
        ```
            payload do pacote UDP será "3,0"
        ```      


### Vamos controlar todas as cores do LED RGB em uma unica requisição

1. Protocolo:
    
    ```
    <status_LED_RED>,<status_LED_GREEN>,<status_LED_BLUE>
    ``` 

1. Exemplos
    1. Ligando LED red, green e blue
        ```
        payload do pacote UDP será "1,1,1"
        ```  
    1. Desligando LED red, green e blue
        ```
            payload do pacote UDP será "0,0,0"
        ```  
    1. Ligando LED red e green e desligando o blue
        ```
            payload do pacote UDP será "1,1,0"
        ``` 
    1. Desligando LED red e green e ligando o blue
        ```
            payload do pacote UDP será "0,0,1"
        ```      

## DESAFIO II: Vamos criar um protocolo mais elaborado ainda?

### Vamos controlar as cores do LED RGB separadamente

1. Protocolo:

    ```
    <id_led>,<PWM_LED>
    ``` 

2. id_led como um identificador da cor do LED
    ```
    '1' -> LED Red
    '2' -> LED Green
    '3' -> LED Blue
    ```

2. status_LED determina o estado do LED:
    ```
    Valor entre '0' e 255, onde:
    '0' -> bilho mínimo do LED, ou seja, desligado
    '255' -> bilho máximo do LED
    ```
1. Exemplos
    1. Controlando LED red
        ```
            payload do pacote UDP será "1,150"
        ```  
    1. Desligando LED green
        ```
            payload do pacote UDP será "1,255"
        ```  

### Vamos controlar todas as cores do LED RGB em uma unica requisição

1. Protocolo:
    
    ```
    <PWM_LED_RED>,<PWM_LED_GREEN>,<PWM_LED_BLUE>
    ``` 

1. Exemplos
    1. Controlando LED red, green e blue
        ```
        payload do pacote UDP será "0,255,100"
        ```  