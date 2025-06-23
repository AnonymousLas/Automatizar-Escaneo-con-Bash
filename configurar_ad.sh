#!/bin/bash

#Aquí te dejo un script llamado configurar_ad.sh que:
#Cambia el DNS en /etc/resolv.conf
#Crea el archivo /etc/krb5.conf con la configuración del dominio
#Verifica que todo se haya configurado correctamente

# Verificación de argumentos
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <IP_DEL_DC> <DOMINIO>"
    echo "Ejemplo: $0 10.10.11.65 scepter.htb"
    exit 1
fi

# Argumentos desde línea de comandos
DC_IP="$1"
DOMINIO="$2"
REALM=$(echo "$DOMINIO" | tr '[:lower:]' '[:upper:]')
KDC="dc01.$DOMINIO"

echo "[*] Configurando entorno para el dominio: $DOMINIO"
echo "[*] IP del controlador de dominio (DC): $DC_IP"
echo "[*] Realm Kerberos: $REALM"
echo "[*] KDC: $KDC"

# 1. Configurar DNS
echo "[+] Escribiendo /etc/resolv.conf"
echo "nameserver $DC_IP" | sudo tee /etc/resolv.conf > /dev/null

# 2. Configurar Kerberos
echo "[+] Escribiendo /etc/krb5.conf"
sudo tee /etc/krb5.conf > /dev/null <<EOF
[libdefaults]
    default_realm = $REALM
    dns_lookup_realm = false
    dns_lookup_kdc = true
    ticket_lifetime = 24h
    forwardable = true

[domain_realm]
    .$DOMINIO = $REALM
    $DOMINIO = $REALM

[realms]
    $REALM = {
        kdc = $KDC
        admin_server = $KDC
        default_domain = $DOMINIO
    }
EOF

echo -e "\n[✔] Configuración completa."
echo -e "\n[📌] Recomendación:"
echo "    - Prueba conectividad con: ping $KDC"
echo "    - Verifica resolución: host -t SRV _kerberos._tcp.$DOMINIO"
echo "    - Usa ahora tools como: certipy, bloodhound-python, impacket, etc."
