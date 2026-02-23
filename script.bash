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
    if [ -z "$1" ]; then
        echo "Usage: extractPorts <nmap-output-file>"
        return 1
    fi

    echo "[+] Extracting information..."
    file="$1"

    # Extraer IP
    ip=$(grep "Host:" "$file" | grep "Ports:" | awk '{print $2}' | head -n1)

    # Extraer puertos abiertos
    ports=$(grep "Host:" "$file" | grep "Ports:" | sed -E 's/.*Ports: //' | tr ',' '\n' | grep '/open' | cut -d '/' -f1 | tr '\n' ',' | sed 's/,$//')
    
    # Eliminar espacios después de las comas
    ports=$(echo "$ports" | sed 's/, /,/g')

    echo -e "\t[+] Target IP Address: $ip"
    echo -e "\t[+] Open Ports: $ports"

    # Copiar al portapapeles (si xclip está instalado)
    if command -v xclip &>/dev/null; then
        echo -n "$ports" | xclip -selection clipboard && echo "[+] Ports have been copied to clipboard!"
    else
        echo "[!] xclip not installed, cannot copy to clipboard"
    fi
}


