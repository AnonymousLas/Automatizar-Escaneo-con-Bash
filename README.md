# ExtractPorts - Extract Open Ports from Nmap Scan Results

## Descripción

`extractPorts` es una función útil para obtener rápidamente los puertos abiertos de un escaneo de Nmap y formatearlos en una lista fácil de usar, todo desde tu terminal. Esta función analiza el archivo de salida de un escaneo de Nmap, extrae los puertos abiertos y los presenta en formato limpio y comprensible, listados por comas (ejemplo: `22,80,443,16667`).

---

## Requisitos

- **Nmap**: Asegúrate de tener instalado Nmap para realizar escaneos de puertos. Puedes instalarlo con el siguiente comando:
  
  ```bash
  sudo apt install nmap

### 1. sudo nmap -p- -T4 -v -n -oG allPorts 192.168.1.1
### 2.     extractPorts allPorts
### 3. nmap -sC -sV -p22,80,443,16667 192.168.1.1 -oN targeted




[+] Extracting information...
        [+] IP Address: 192.168.1.44
        [+] Open ports: 22,80,443,16667
[+] Ports have been copied to clipboard!


Este código está listo para ser copiado y pegado directamente en tu archivo `README.md`. Si necesitas algún ajuste adicional o tienes alguna otra pregunta, no dudes en decírmelo. ¡Estoy aquí para ayudarte!
