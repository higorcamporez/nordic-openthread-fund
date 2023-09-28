## Aula 3 - Exercício 1: Comunicação externa usando CoAP CLI e Border Router

Use o projeto o [Nordic openthread CLI](https://developer.nordicsemi.com/nRF_Connect_SDK/doc/latest/nrf/samples/openthread/cli/README.html) como base para esse exercicio

## Confgurando o projeto para se conectar automaticamente a rede Thread do border router
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

## Recebendo requisições CoAP
### Requisição GET ao coap.me/test
1. IPv6 a partir do IPv4 do servidor coap.me

    prefixo da rede thread IPv6 (fdfd:d7e3:ff4c:2:0:0::) + coap.me IPv4 (134.102.218.18)

    ```bash
    fdfd:d7e3:ff4c:2:0:0::134.102.218.18
    ```
    use esse IPv6 na requisição abaixo

1. Ative o coap
    ```bash
    > coap start
    Done
    ```

1. Envie a requisição GET CoAP ao recurso `test`
    
    Comando: `get <address> <uri-path> [type]`

    ```bash
    > ot coap get fdfd:d7e3:ff4c:2:0:0:8666:da12 hello
    Done
    coap response from fdfd:d7e3:ff4c:2:0:0:8666:da12 with payload: 776f726c64
    ```
1. Converta o payload da resposta em hexadecimal para ASCII

    [Hex to ASCII Text String Converter](https://www.rapidtables.com/convert/number/hex-to-ascii.html)

<!--
### Preparando a placa nordic como CoAP Server

1. Ative o coap, caso não tenho ativado no passo anterior
    ```bash
    > coap start
    Done
    ```
1. Adicione o recurso `test-resource` ao CoAP Server 

    Comando: `resource [uri-path]`

    ``` bash
    > coap resource test-resource
    Done
    ```

## Enviando requisições CoAP 

### Via Android APP
-->