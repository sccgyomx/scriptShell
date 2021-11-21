
#!/bin/bash
# Bash Menu Script Example
# Funcion para leer los usuarios por nombre y apellidos.
agregar_usuarios () {
    echo "---------------------------------------------------"
    read -p "Ingrese el nombre: " nombre
    nombre="${nombre^}"
    read -p "Ingrese el apellido paterno: " apellido1
    apellido1="${apellido1^}"
    read -p "Ingrese el apellido materno: " apellido2
    apellido2="${apellido2^}"
    nombrecompleto="$nombre $apellido1 $apellido2"
    read -a nombre <<< "$nombre"
    usuario="${nombre[0]}${apellido1:0:3}${apellido2:0:2}"
    usuario="${usuario,,}"
    usuario="${usuario^}"
    arreglousuarios[$i]=$usuario
    arreglonombres[$i]=$nombrecompleto
    clear
}

# Funcion para mostrar todos los usuarios
mostrar_usuarios () {
    echo "-----------------------------------------------------------------"
    echo "Nombre: ${arreglonombres[i]}"
    echo "Usuario: ${arreglousuarios[i]}"
    echo
    # Descomentar la linea siguiente para agregar los usuarios
    #sudo useradd -m ${arreglousuarios[i],,}
    read -p "Presiona una tecla para continuar" opcion1
    clear
}

menu () {
    echo "漣 Menu 漣"
        for ((i=1;i<6;i++));
        do
            echo "$i) ${options[i-1]}"
        done
}

PS3='﬽  Por favor selescione una opción: '
options=("Agregar Usuario" "Optener ultimas acciones de un usuario" "Mostrar usuarios que intentaron iniciar sesión con contraseña erronea" "Mostrar los accesos de los usuarios al sistema, que no sean el root" "Quit")
echo "漣 Menu 漣"
select opt in "${options[@]}"
do
    case $opt in
        "Agregar Usuario")
            echo " Nuevo Usuario "
            agregar_usuarios
            mostrar_usuarios
            menu
            ;;
        "Optener ultimas acciones de un usuario")
            echo "﨟 Ultimas acciones del Usuario 﨟"
            menu
            ;;
        "Mostrar usuarios que intentaron iniciar sesión con contraseña erronea")
            echo " Lista de usuarios que intentaron entrar con contraseña erronea "
            menu
            ;;
        "Mostrar los accesos de los usuarios al sistema, que no sean el root")
            echo " Lista de usuarios que no son root "
            menu
            ;;
        "Quit")
            echo " Saliendo "
            break
            ;;
        *) 
            echo " La opcion $REPLY es invalida "
            menu
            ;;
    esac
done