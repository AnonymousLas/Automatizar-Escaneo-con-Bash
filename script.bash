nano ~/.zshrc


#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


function extractPorts() {
    echo -e "\033[1;33m[+] Extracting information... \033[0m"
    
    # Obtener la dirección IP (usamos hostname -I para obtener la IP de la máquina local)
    ip_address=$(hostname -I | awk '{print $1}')
    
    # Obtener los puertos abiertos desde el archivo de salida de Nmap (allPorts1)
    open_ports=$(grep -oP '\d+/open/tcp' allPorts1 | cut -d'/' -f1 | tr '\n' ',')
    
    # Eliminar la última coma sobrante
    open_ports=$(echo $open_ports | sed 's/,$//')
    
    # Mostrar la IP y los puertos
    echo -e "\t\033[1;34m[+] IP Address: \033[1;30m$ip_address\033[0m"
    echo -e "\t\033[1;34m[+] Open ports: \033[1;30m$open_ports\033[0m"

    # Copiar los puertos al portapapeles
    echo $open_ports | tr -d '\n' | xclip -sel clip
    echo -e "\033[1;33m[+] Ports have been copied to clipboard! \033[0m"
}


