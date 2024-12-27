clear
BLACK='\033[30m'
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
CYAN='\033[34m'
MAGENTA='\033[35m'
BLUE='\033[36m'
WHITE='\033[37m'
RESET='\033[0m'


toilet -f slant -F border --gay "Tracer IP" | lolcat
           echo -e "${GREEN}"
           read -p "Masukkan IP yang mau di tracer => " ip_address
            echo -e "${RESET}"

            if [ -z "$ip_address" ]; then
                echo -e "${RED}IP Address tidak boleh kosong!${RESET}"
                exit 1
            fi

            # Spinner Start
            spinner &
            SPINNER_PID=$!

            # Melakukan pelacakan IP
            response=$(curl -s "http://ip-api.com/json/$ip_address")

            # Stop spinner setelah mendapatkan hasil
            kill $SPINNER_PID

            # Parsing hasil JSON
            status=$(echo $response | jq -r '.status')

            if [ "$status" == "success" ]; then
                country=$(echo $response | jq -r '.country')
                region=$(echo $response | jq -r '.regionName')
                city=$(echo $response | jq -r '.city')
                isp=$(echo $response | jq -r '.isp')
                timezone=$(echo $response | jq -r '.timezone')
                lat=$(echo $response | jq -r '.lat')
                lon=$(echo $response | jq -r '.lon')

                echo -e "${GREEN}Hasil Pelacakan IP:${RESET}"
                echo -e "  ${CYAN}Negara   : ${RESET}$country"
                echo -e "  ${CYAN}Provinsi : ${RESET}$region"
                echo -e "  ${CYAN}Kota     : ${RESET}$city"
                echo -e "  ${CYAN}ISP      : ${RESET}$isp"
                echo -e "  ${CYAN}Zona Waktu: ${RESET}$timezone"
                echo -e "  ${CYAN}Latitude : ${RESET}$lat"
                echo -e "  ${CYAN}Longitude: ${RESET}$lon"
                echo -e "  ${CYAN}Lokasi di Peta: https://www.google.com/maps?q=$lat,$lon"
            else
                echo -e "${RED}Gagal melacak IP. Pastikan IP valid.${RESET}"
            fi
