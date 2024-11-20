# ExtractPorts - Extract Open Ports from Nmap Scan Results

## Descripción

`extractPorts` es una función útil para obtener rápidamente los puertos abiertos de un escaneo de Nmap y formatearlos en una lista fácil de usar, todo desde tu terminal. Esta función analiza el archivo de salida de un escaneo de Nmap, extrae los puertos abiertos y los presenta en un formato limpio y comprensible, listados por comas (ejemplo: `22,80,443,16667`).

## Requisitos

- **Nmap**: Asegúrate de tener instalado Nmap para realizar escaneos de puertos. Puedes instalarlo y ejecutar el siguiente flujo de comandos:

  ```bash
  # Escaneo completo de todos los puertos
  sudo nmap -p- -T4 -v -n -oG allPorts 192.168.1.1
  
  # Extraer puertos abiertos utilizando extractPorts
  extractPorts allPorts
  
  # Escaneo dirigido con scripts y detección de servicios
  nmap -sC -sV -p22,80,443,16667 192.168.1.1 -oN targeted
