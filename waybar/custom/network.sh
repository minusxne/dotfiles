#!/bin/bash

#получение активного интерфейса
interface=$(ip route | grep default | awk '{print $5}')
#получение ip-адреса через активный интерфейс
ip_address=$(ip -4 addr show "$interface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

#состояние подключения ethernet
eth_operstate=$(cat /sys/class/net/enp37s0/operstate)
eth_operstate1=$(cat /sys/class/net/enp0s20f0u3/operstate)
#состояние подключения wifi
wifi_operstate=$(cat /sys/class/net/wlo1/operstate)



if [[ "$eth_operstate" == "up" || "$eth_operstate1" == "unknown" ]]; then
    echo "{\"text\": \"󰈀 eth\", \"class\": \"ethernet\", \"tooltip\": \"$ip_address\"}"
fi


if [[ "$wifi_operstate" == "up" ]]; then
    echo "{\"text\": \" wifi\", \"class\": \"wifi\", \"tooltip\": \"$ip_address\"}"
fi

if [[ "$wifi_operstate" != "up" && "$eth_operstate" != "up" ]]; then
    echo "{\"text\": \" disconnected\", \"class\": \"disconnected\"}"
fi