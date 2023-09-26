## Aula 2 - Exercício 1: Comunicação externa usando Border Router
## Conectando a rede Thread do border router
1. Redefinindo as configurações de fábrica
    ```bash
    > ot factoryreset
    ```
1. Parando a rede thread default
    ```bash
    > ot thread stop
    Done
    ```

1. Mudando o panid para modo joiner
    ```bash
    > ot panid 0xffff
    ```
2. Iniciando o Joiner
    ```bash
    > ot ifconfig up
    Done
    > ot joiner start 123456
    Done
    Join success
    ```
1. Iniciando o serviço Thread para conexão
     ```bash
     > ot thread start
    Done
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

## Enviando ping externamente

### Enviando ping ao google.com

1. Abra o prompt de comando do **seu computador** e digite o seguinte comando para descobrir o IP do google, pois o comando `ping` da placa não faz o serviço de DNS
    ```bash
    > ping google.com
    Disparando google.com [XXX.XXX.XXX.XXX] com 32 bytes de dados:
    Resposta de XXX.XXX.XXX.XXX: bytes=32 tempo=22ms TTL=118
    Resposta de XXX.XXX.XXX.XXX: bytes=32 tempo=27ms TTL=118
    Resposta de XXX.XXX.XXX.XXX: bytes=32 tempo=22ms TTL=118
    ....
    ```
2. Enviando um ping ao google.com a partir da rede Thread usando o IP do passo anterior
    ```bash
    > ot ping XXX.XXX.XXX.XXX
    Pinging synthesized IPv6 address: xxxx:xxxx:xxxx:x:x:x:xxxx:xxxx
    16 bytes from xxxx:xxxx:xxxx:x:x:x:xxxx:xxxx: icmp_seq=1 hlim=117 time=80ms
    1 packets transmitted, 1 packets received. Packet loss = 0.0%. Round-trip min/avg/max = 80/80.0/80 ms.
    Done
    ```

    note o IP do google é v4 e foi convertido para v6

## Recebendo pacotes UDP da rede externa

### Preparando a placa nordic para receber pacotes
1. Ativando o UDP socket
    ```bash
    > ot udp open
    Done
    ```
1. Vinculando uma porta UDP socket listener 

    Comando: `bind [netif] <ip> <port>`

    ``` bash
    > ot udp bind :: 1234
    Done
    ```

    O símbolo `::` determina que o endereço IPv6 não é especificado, ou seja, aceita-se pacote de qualquer IPv6.

### Preparando o smartphone Android para enviar pacotes
1. descobrindo o IPv6 global da placa nordic na rede Thread
    ```bash
    > ot ipaddr -v
    fd11:22:0:0:7046:8b7c:fe3d:81bd origin:slaac
    fd8d:1d8a:2936:e08c:0:ff:fe00:b000 origin:thread
    fd8d:1d8a:2936:e08c:bd0a:8f97:714c:557f origin:thread
    fe80:0:0:0:102b:117c:e47:5aeb origin:thread
    Done
    ```
    O IP que possui `origin:slaac` no final é o ip global (externo a rede Thread)

2. Baixe o aplicativo de teste e envie uma mensagem para o IP descoberto no passo anterior e porta configurada (1234)

    [UDP terminal](https://play.google.com/store/apps/details?id=com.hardcodedjoy.udpterminal&hl=en_US)

1. Ajuste o **Remote IP** e **Remote Port** para o IP e porta (1234) da placa nas configurações do APP
    <p align="center">
    <img src="https://play-lh.googleusercontent.com/DY-aqauXDmnVvcbTgL-O15beDP5g98k9bI758ZuvU5_WJ6-BldxbBHIcu_61wCLcLmQ=w2560-h1440-rw" width="200" title="hover text">
    <p>

## Enviando pacotes UDP externamente

1. No aplicativo do passo anterior, habilite a função `local echo` para receber mensagens da placa nordic e `Local Port` para 1234

1. Enviando uma mensagem UDP a partir da placa nordic, onde é preciso preencher o IP do smartphone e porta escolhida nas configurações

    Comando: `udp send <ip> <port> <type> <value>`

    ```bash
    > ot udp send 192.168.0.162 1234 hello
    Done
    ```

## Trocando pacotes TCP com rede externa
### Preparando o TCP server no smartphone
1. Baixe o seguinte APP Android

    [Simple TCP Socket Tester](https://play.google.com/store/search?q=simple+tcp+socket+tester&c=apps&hl=en_US)

1. Ative o servidor na porta 1234
<p align="center">
  <img src="https://play-lh.googleusercontent.com/eVKcdh1E1Oj9nKu6W4_pzeWrWqgyzBu6QF2u6RbteCngklBektaNI9wXQkLV8uNwACo=w2560-h1440-rw" width="200" title="hover text">
<p>

### Conectando a placa nordic ao servidor TCP no smartphone

1. Habilitando o TCP
    ```bash
    > ot tcp init
    Done
    ```
2. Estabelecendo uma conexão TCP com o servidor
    
    Comando: `connect <ip> <port> [<fastopen>]`

    ```bash
    > ot tcp connect 192.168.0.162 1234
    Connecting to synthesized IPv6 address: fdfd:d7e3:ff4c:2:0:0:c0a8:a2
    Done
    TCP: Connection established
    ```
3. Enviando uma mensagem de hello
    
    ```bash
    > ot tcp send hello
    Done
    ```

4. Envie uma mensagem do smartphone para a placa nordic
    ```bash
    TCP: Received 2 bytes: Hello
    ```
