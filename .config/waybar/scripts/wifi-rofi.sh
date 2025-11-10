#!/bin/bash
# Получаем список известных сетей
KNOWN_NETWORKS=$(nmcli -t -f NAME connection show | grep -v '^$')

# Показываем список сетей (для неизвестных показываем замок)
NETWORK=$(nmcli -t -f SSID,SIGNAL,SECURITY device wifi list | \
          sort -t':' -k2 -nr | \
          awk -F: '!seen[$1]++' | \
          awk -F: '{known=0; for(k in known_arr) if(k==$1) known=1; if(known==0 && $3 != "") print $1 " | "; else print $1}' | \
          wofi --dmenu --prompt "Сети:" --style ~/.config/wofi/style.css --location center --width 350 --height 300)

if [ -n "$NETWORK" ]; then
    SSID=$(echo "$NETWORK" | cut -d'|' -f1 | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    
    # Проверяем известна ли сеть
    if echo "$KNOWN_NETWORKS" | grep -q "^$SSID$"; then
        # Сеть известна - сразу подключаем
        nmcli connection up "$SSID"
    else
        # Сеть неизвестна - проверяем защищена ли
        if echo "$NETWORK" | grep -q ""; then
            # Защищенная - запрашиваем пароль
            PASSWORD=$(wofi --dmenu --password --prompt "Пароль:" --style ~/.config/wofi/style.css --location center --width 300)
            if [ -n "$PASSWORD" ]; then
                nmcli device wifi connect "$SSID" password "$PASSWORD"
            fi
        else
            # Открытая - подключаем сразу
            nmcli device wifi connect "$SSID"
        fi
    fi
fi

