# Aula 1: Comandos do openthread CLI
Os comandos desta aula são executados a partir do exemplo do [Nordic openthread CLI](https://developer.nordicsemi.com/nRF_Connect_SDK/doc/latest/nrf/samples/openthread/cli/README.html).

Atenção: adicione o **overlay-tcp.conf** no kconfig fragments para habilitar o uso do TCP.


Caso seu dispositivo seja o **nRF52840 dongle**, adicione também o **overlay-usb.conf** no kconfig fragments e o **usb.overlay** ao device tree overlay para habilitar o uso do USB para comunicação de mensagens.


## Configurando uma rede Thread
1. Desativando a interface Thread
    ```bash
    > ot ifconfig down
    Done
    > ot thread stop
    Done
    ```

1. Gerando novas configurações da rede
    ```bash
    > ot dataset init new
    Done
    ```

2. Visualizando as configurações geradas
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

3. Modificando o nome da rede (opcional)
    ```bash
    > ot dataset networkname openthread-ufes
    Done
    ```

4. Modificando a senha da rede (opcional)
    ```bash
    > ot dataset networkkey 00112233445566778899aabbccddeeff
    Done
    ```
5. Modificando o panid (opcional)
    ```bash
    > ot dataset panid 0x1234
    Done
    ```

<!--
5. Modificando o canal (opcional)
    1. Analisando os status dos canais
        ```bash
        > ot channel monitor
        channel monitor
        enabled: 1
        interval: 41000
        threshold: -75
        window: 960
        count: 10552
        occupancies:
        ch 11 (0x0cb7)  4.96% busy
        ch 12 (0x2e2b) 18.03% busy
        ch 13 (0x2f54) 18.48% busy
        ch 14 (0x0fef)  6.22% busy
        ch 15 (0x1536)  8.28% busy
        ch 16 (0x1746)  9.09% busy
        ch 17 (0x0b8b)  4.50% busy
        ch 18 (0x60a7) 37.75% busy
        ch 19 (0x0810)  3.14% busy
        ch 20 (0x0c2a)  4.75% busy
        ch 21 (0x08dc)  3.46% busy
        ch 22 (0x101d)  6.29% busy
        ch 23 (0x0092)  0.22% busy
        ch 24 (0x0028)  0.06% busy
        ch 25 (0x0063)  0.15% busy
        ch 26 (0x058c)  2.16% busy

        Done
        ```

        Atenção: é necessário habilitar a configuração [CONFIG_OPENTHREAD_CHANNEL_MONITOR](https://developer.nordicsemi.com/nRF_Connect_SDK/doc/1.9.2-dev1/kconfig/CONFIG_OPENTHREAD_CHANNEL_MONITOR.html#std-kconfig-CONFIG_OPENTHREAD_CHANNEL_MONITOR) para que o comando funcione. Adicione o seguinte comando ao prj.conf
        ```
        CONFIG_OPENTHREAD_CHANNEL_MONITOR=y
        ```
    --> 
2. Modificando o número do canal
    ```bash
    > ot dataset channel 11
    Done
    ```
1. Confirmando e salvando as novas configurações em memoria não volátil

    ```bash
    > ot dataset commit active
    Done
    ```

1. Habilitando interface Thread

    ```bash
    > ot ifconfig up
    Done
    > ot thread start
    Done
    ```
Para modificar outros atributos leia mais em [dataset](https://github.com/openthread/openthread/blob/main/src/cli/README_DATASET.md)

## Verificando redes Threads existentes
1. Verificando as redes disponiveis pelo comando `discover`
    
    Comando: `discover [channel]`
    
    ```bash
    > ot discover
    | J | Network Name     | Extended PAN     | PAN  | MAC Address      | Ch | dBm | LQI |
    +---+------------------+------------------+------+------------------+----+-----+-----+
    | 0 | OpenThread       | dead00beef00cafe | ffff | f1d92a82c8d8fe43 | 11 | -20 |   0 |
    Done
    ```
1. Verificando as redes disponiveis pelo comando `scan`

    Comando: `scan [channel]`
    
    ```bash
    > ot scan
    | PAN  | MAC Address      | Ch | dBm | LQI |
    +------+------------------+----+-----+-----+
    | ffff | f1d92a82c8d8fe43 | 11 | -20 |   0 |
    Done
    ```

## Conectando a uma rede Thread existente

### Via commisioning
Referência [OpenThread CLI - Commissioning](https://github.com/openthread/openthread/blob/main/src/cli/README_COMMISSIONING.md)

#### Iniciando a seção de comisionamento
No disposito router já pertecente a rede Thread, execute os seguintes passos

1. Iniciando a função de commisioner
    ```bash
    > ot commissioner start
    Commissioner: petitioning
    Done
    Commissioner: active
    ```

2. Adicionando uma seção de comissionamento

    Comando: `commissioner joiner add <eui64>|<discerner> <pskd> [timeout]`

    Adicionando uma entidade Joiner

    - eui64: a chave IEEE EUI-64 do dispositivo Joiner ou '\*' para aceitar qualquer dispositivo.
    - discerner: The Joiner discerner in format `number/length`.
    - pskd: chave pré-compartilhada (senha) para o Joiner.
    - timeout: tempo em segundo em que o joiner irá expirar.

    ```bash
    > ot commissioner joiner add * J01NME 10000
    Done
    ```

3. Visualizando a tabela de joiner
    ```bash
    > ot commissioner joiner table
    | ID                    | PSKd                             | Expiration |
    +-----------------------+----------------------------------+------------+
    |                     * |                           J01NME |      81015 |
    |      d45e64fa83f81cf7 |                           J01NME |     101204 |
    | 0x0000000000000abc/12 |                           J01NME |     114360 |
    Done
    ```
#### Iniciando o processo de comissionamento
No disposito que irá se conectar a rede Thread, execute os seguintes passos

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
    > ot joiner start J01NME
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
    Network Name: openThread-ufes
    PAN ID: 0x1234
    PSKc: 3ca67c969efb0d0c74a4d8ee923b576c
    Security Policy: 672 onrc 0
    Done
    ```

### Via networkkey
Somente a networkkey é necessária para que um dispositivo se conecte a uma rede Thread.

1. Redefinindo as configurações de fábrica
    ```bash
    > ot factoryreset
    ```

1. Desativando interface Thread
    ```bash
    > ot ifconfig down
    Done
    > ot thread stop
    Done
    ```

1. Criando uma configuração parcial no dataset ativo
    ```bash
    > ot dataset networkkey 00112233445566778899aabbccddeeff
    Done
    ```

1. Adicionando o canal (opcional)

    Embora não seja obrigatório, a especificação do canal evita a necessidade de pesquisar vários canais, melhorando a latência e a eficiência do processo de conexão.
    ```bash
    > ot dataset channel 11
    Done
    ```

1. Confirmando e salvando as novas configurações em memoria não volátil

    ```bash
    > ot dataset commit active
    Done
    ```

1. Habilitando interface Thread

    ```bash
    > ot ifconfig up
    Done
    > ot thread start
    Done
    ```

3. Validando os dados esperados da rede Thread após conexão

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


## Transformando um router em um end device
1. Verificando o estado do dispositivo
    ```bash
    > ot state
    router
    Done
    ```
1. Verficando o estado atual do modo router
    ```bash
    > ot routereligible
    Enabled
    Done
    ```
1. Desabilitando o modo router
    ```bash
    > ot routereligible disable
    Done
    ```
1. Verificando o estado do dispositivo
    ```bash
    > ot state
    child
    Done
    ```
## Validando a conexão com Ping
1. Descubrindo o endereço de um dispositivo na rede mesh para executar o ping
    ```bash
    > ot ipaddr mleid
    fd83:c7ab:e96a:cd01:3fff:97e0:e6f7:b9d6
    Done
    ```
2. Executando o ping
    ```bash
    > ot ping fd83:c7ab:e96a:cd01:3fff:97e0:e6f7:b9d6
    16 bytes from fd83:c7ab:e96a:cd01:0:ff:fe00:fc00: icmp_seq=1 hlim=64 time=11ms
    1 packets transmitted, 1 packets received. Packet loss = 0.0%. Round-trip min/avg/max = 11/11.0/11 ms.uart
    ```

## Enviando pacotes UDP

[Link para campartilhamento de IPs](https://docs.google.com/document/d/1vyUV47gHinF-xTYLZZwq0btTZh-BhY7RQ0jhlOCcDsQ/edit?usp=sharing) 

### Dispositivo receptor
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

### Dispositivo transmissor
1. Habilitando o UDP socket
    ```bash
    > ot udp open
    Done
    ```
1. Enviando uma mensagem Hello

    Comando: `udp send <ip> <port> <type> <value>`

    ```bash
    > ot udp send fdde:ad00:beef:0:bb1:ebd6:ad10:f33 1234 hello
    Done
    ```

    obs: adicione o IPv6 do destinatário

### Encerrando UDP socket
```bash
> ot udp close
Done
```
## Enviando pacotes TCP

### Dispositivo 1 - Server
1. Habilitando o TCP
    ```bash
    > ot tcp init
    Done
    ```
1. Ativando o tcp listener
    
    comando: `listen <ip> <port>`

    ```bash
    > ot tcp listen :: 30000
    Done
    ```
    O simbolo `::` determina que o endereço IPv6 não é especificado, ou seja, aceita-se pacote de qualquer IPv6.

### Dispositivo 2 - Client

1. Habilitando o TCP
    ```bash
    > ot tcp init
    Done
    ```
2. Estabelecendo uma conexão TCP
    
    Comando: `connect <ip> <port> [<fastopen>]`

    ```bash
    > ot tcp connect fe80:0:0:0:a8df:580a:860:ffa4 30000
    Done
    TCP: Connection established
    ```
3. Enviando uma mensagem de hello
    
    ```bash
    > ot tcp send hello
    Done
    ```
    após estabelecer a conexão o comando de `send` também funcionará para o dispositivo 1


### Encerrando uma conexão TCP
```bash
> ot tcp deinit
TCP: Connection reset
Done
```

    

