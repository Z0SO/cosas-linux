#!/bin/bash

tput civis    # oculta el cursor

# colorines
green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
ylw="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquesa="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"

function ctrl_c() {
    echo -e "\n${red}[*]${end} ${gray}SALIENDO...${end}"
    tput cnorm    # muestra el cursor
    exit 1
}

trap ctrl_c INT


# -----------------------------------------------
# Autor: Z0SO
# Descripción: Script de prueba para mostrar el uso de getopts y funciones en bash.
# -----------------------------------------------


# variables -------------------------------------
declare -i var1=0
url_file="https://htbmachines.github.io/bundle.js"



# Funciones -------------------------------------

# Funcion de muestra del panel de ayuda
function panel_help(){
    echo -e "\n${green}[*]-------${end} ${gray}Panel de ayuda${end} ${green}-------[*]${end}\n"


    echo -e "\t${green}[-m]${end} ${gray}Buscar una máquina por ${ylw}nombre${end}${gray}.${end}"
    echo -e "\t${green}[-i]${end} ${gray}Buscar una máquina por ${ylw}Direccion IP${end}${gray}.${end}"
    echo -e "\t${green}[-u]${end} ${gray}Actualizar archivos.${end}"
    echo -e "\t${green}[-h]${end} ${gray}Mostrar panel de ayuda.${end}"
    echo -e "\t${green}[-i]${end} ${gray}Buscar una máquina con la ip que se pasa como argumento.${end}"
    echo -e "\t${green}[-y]${end} ${gray}Buscar el link de youtube de la máquina que se pasa como argumento.${end}"
    echo -e "\t${green}[-d]${end} ${gray}Buscar una máquina por la dificultad que se pasa como argumento. ${purple}[Fácil, Medio, Difícil, Insane]${end}${end}"

}




function update_files(){
    # esta funcion se encarga de descargar el archivo bundle.js y formatearlo.
    
    clear
    echo -e "${green}[*]${end} ${gray}Actualizando archivos...${end}\n"
    sleep 2

    # el ! en bash es para negar, en este caso se comprueba si el archivo bundle.js no existe.
    if [ ! -f bundle.js ]; then
        
        echo -e "${red}[*]${end} ${gray}El archivo bundle.js no existe.${end}\n"
        sleep 1
        echo -e "${green}[*]${end} ${gray}Descargando el archivo bundle.js...${end}\n"

        curl -s -X GET $url_file > bundle.js    # Se le podria qutar el -X GET, ya que por defecto es GET.

        # js-beautify es una herramienta que permite formatear el código javascript.
        # sponge es una herramienta que permite redirigir la salida de un comando a un archivo.
        js-beautify bundle.js | sponge bundle.js

    else
        # la idea de este else es que si el archivo ya existe, se deba verificar una actulaziación del archivo.
        # ultilizando md5sum o sha256sum para verificar si el archivo ha sido modificado.
        echo -e "${green}[*] El archivo bundle.js ya existe.${end}\n"
        sleep 1
        echo -e "${green}[*]${end} ${gray}Comprobando actualizaciones...${end}\n"

        sleep 1 # DEBUG

        curl -s -X GET $url_file > bundle_temp.js
        js-beautify bundle_temp.js | sponge bundle_temp.js

        # se comprueba si el archivo ha sido modificado.
        original_value=$(md5sum bundle.js | awk '{print $1}')
        temp_value=$(md5sum bundle_temp.js | awk '{print $1}')

        echo -e "${green}[*]${end} ${gray}Valor original: ${end}${ylw}$original_value${end}"
        echo -e "${green}[*]${end} ${gray}Valor temporal: ${end}${green}$temp_value${end}\n"

        # la diferencia entre comparar las variables con "" y sin "" es que si se comparan con "", se comparan como cadenas de texto.
        # de lo contrario se comparan como números.
        if [ "$original_value" == "$temp_value" ] ; then
            echo -e "${green}[*]${end} ${gray}No hay actualizaciones.${end}\n"
            rm bundle_temp.js
        else
            echo -e "${green}[*]${end} ${gray}Actualizando archivo...${end}\n"
            sleep 1
            rm bundle.js && mv bundle_temp.js bundle.js
        fi
    fi

    # este if comprueba si el comando anterior se ha ejecutado correctamente.
    if [ $? -eq 0 ]; then
        echo -e "${green}[*]${end} ${gray}Archivo formateado correctamente.${end}\n"
        
        # tiramos un bat con sintaxis javascript para buscar la máquina en el archivo formateado.
        
        # cateamos el archivo bundle.js y buscamos la máquina en concreto.
        # bat bundle.js --language=js
    else
        echo -e "${red}[*]${end} ${gray}Error al formatear el archivo.${end}\n"
    fi
}

<<<<<<< HEAD
=======

function buscar_youtube(){
    # esta funcion devuelve el link de youtube a la maquina que se pasa como argumento.
    maquina="$1" 

    link=$(cat bundle.js | awk "/name: \"$maquina\"/ , /resuelta:/" | sed "s/ *//" | grep youtube | awk 'NF{print $NF}' | tr -d ',|"')
   
    if [ $link ];
    then
        echo -e "${green}[*]${end} ${gray}El link de youtube de la máquina ${end}${ylw}Tentacle${end}${gray} es -> ${end}${turquesa}$link${end}\n"
    else
        echo -e "${red}[!]${end} ${gray}No se ha encontrado el link de youtube.${end}\n"
    fi
}

>>>>>>> 8591d2a6b4298655566ed1dce323eddaa7f043ec
function buscar_maquina(){
    # esta funcion se encarga de buscar una máquina en el archivo bundle.js.
    clear
    
    mensaje="$*"

    echo -e "${green}[*]${end} ${gray}Buscando la máquina con el nombre -> ${end}${ylw}$mensaje${end}\n"
<<<<<<< HEAD
=======


    # con el comando cat se muestra el contenido del archivo bundle.js
    #
    cat bundle.js | awk "/name: \"${mensaje}\"/,/resuelta/" | grep -vE 'id|sku:|resuelta' | tr -d '"' | tr -d ',' | sed 's/^ */ [+] /'


>>>>>>> 8591d2a6b4298655566ed1dce323eddaa7f043ec
}

function buscar_por_ip(){
    # esta funcion se encarga de buscar una máquina por la ip.
    dir_ip="$1"
    echo -e "${green}[*]${end} ${gray}Buscando la máquina con la ip -> ${end}${ylw}$dir_ip${end}\n"
    sleep 2
    clear
    # cat bundle.js | awk "/ip: \"${dir_ip}\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta" | tr -d '"' | tr -d ','
    ip_var="$(cat bundle.js | grep "ip: \"10.10.10.5\"" -B3 | grep "name" | awk 'NF{print $NF}' | tr -d '"|,')"

    echo -e "${green}[*]${end} La maquina con la ip ${ylw}$dir_ip${end} se llama -> ${turquesa}$ip_var${end}\n"

    echo -e "${green}[*]${end} ${gray}Listando información de la máquina...${end}\n"
    sleep 1
    buscar_maquina $ip_var
}

<<<<<<< HEAD
=======
# Funcion para buscar por la dificultad
function buscar_dificultad(){
    # esta funcion se encarga de buscar una máquina por la dificultad.
    dif="$1"
    echo -e "${green}[*]${end} ${gray}Buscando la máquina con la dificultad -> ${end}${ylw}$dif${end}\n"
    sleep 2
    clear
    
    una_dificultad=$(cat bundle.js | grep "$dif" -B 5 | sed "s/ */󰇴 /" | sed " s/: / -> /" | tr -d '"|,' | grep -vE "id|sku" | sed "s/󰇴 --/~~~~~~~~~~~~~~~~~~~~~~~~/"   )
   
    if [ ! $una_dificultad ]; then
        echo -e "${red}[!]${end} ${gray}No se ha encontrado ninguna máquina con la dificultad ${end}${ylw}$dif${end}${gray}.${end}\n"
        echo -e "${red}[!]${end} ${gray}Las dificultades son -> ${end}${purple}[Fácil, Medio, Difícil, Insane]${end}\n"
        echo -e "${red}[!]${end} ${gray}Ten en cuenta las tildes...${end}\n"
        tput cnorm    # muestra el cursor
        exit 1
    else
        echo -e "${green}[*]${end} ${gray}Máquinas con la dificultad ${ylw}$dif${end}${gray}:${end}\n"
        echo -e "${una_dificultad}"
    fi
}
>>>>>>> 8591d2a6b4298655566ed1dce323eddaa7f043ec

#--------------------------- Nucleo del script -----------------------------

# getopts es una función que permite pasar argumentos a un script, en este caso se pasan los argumentos -h y -m
# m: indica que se espera un argumento después de la m, en este caso el argumento es el mensaje.
# h: indica que no se espera un argumento después de la h, en este caso se muestra el panel de ayuda.
# arg: es la variable que se utiliza para almacenar los argumentos que se pasan al script.

while getopts "m:uhi:y:d:" arg; do
    case $arg in
        m)
            var1=1
            echo -e "${ylw}[~]${end}DEBUG: ${gray}Se ha pasado el argumento -m${end}"
            sleep 2
            # $OPTARG es la variable que almacena el argumento que se pasa al script. es una variable.
            mensaje=$OPTARG     
            ;;
        u)
            echo -e "${ylw}[~]${end}DEBUG: ${gray}Se ha pasado el argumento -u${end}"
            sleep 2
            var1=2
            ;;
        i)
            echo -e "${ylw}[~]${end}DEBUG: ${gray}Se ha pasado el argumento -i${end}"; sleep 1
            ip_address=$OPTARG
            var1=3
            ;;

        h)
            var1=-1
            ;;
        i)
            echo -e "${ylw}[~]${end}DEBUG: ${gray}Se ha pasado el argumento -i${end}"
            sleep 2
            var1=3  # Entra en buscar por ip
            dir_ip=$OPTARG
            ;;
        y)
            echo -e "${ylw}[~]${end}DEBUG: ${gray}Se ha pasado el argumento -y${end}"
            sleep 2
            var1=4
            maquina=$OPTARG
            ;;
        d)
            echo -e "${ylw}[~]${end}DEBUG: ${gray}Se ha pasado el argumento -d${end}"
            sleep 2
            var1=5
            dif=$OPTARG
            ;;
    esac
done
# si no se pasa ningún argumento al script, se muestra el panel de ayuda.
# si se pasa el argumento -m, se muestra el mensaje que se pasa después del argumento -m.

if [ $var1 -eq -1 ]; then
    clear
    panel_help
elif [ $var1 -eq 1 ]; then    # entra por aquí si se pasa el argumento -m
    buscar_maquina $mensaje
elif [ $var1 -eq 2 ]; then      # entra por aquí si se pasa el argumento -u 
    # funcion update_files
    update_files
elif [ $var1 -eq 1 ]; then
    # funcion buscar_maquina
    buscar_maquina $mensaje
elif [ $var1 -eq 3 ]; then
    # funcion buscar_por_ip
    buscar_por_ip $dir_ip
elif [ $var1 -eq 4 ]; then
    # funcion buscar_youtube
    buscar_youtube $maquina
elif [ $var1 -eq 5 ]; then
    # funcion buscar_dificultad
    buscar_dificultad $dif
else
    echo -e "${red}[*]${end} ${gray}Error en los argumentos.${end}"
    panel_help
fi

#--------------------------------- DEBUG ---------------------------------

<<<<<<< HEAD
echo -e "${ylw}[~] DEBUG: ${end}${gray}Sleep 5 segundos...${end}"
=======

echo -e "\n${ylw}[~] DEBUG: ${end}${gray}Sleep 5 segundos...${end}\n"
>>>>>>> 8591d2a6b4298655566ed1dce323eddaa7f043ec
sleep 5

tput cnorm    # muestra el cursor
