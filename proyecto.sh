
#!/bin/bash
# Bash Menu Script Example
# Funcion para leer los usuarios por nombre y apellidos.
agregar_usuarios () {
    echo "---------------------- -----------------------------"
    echo "La contraseña del nuevo usuario debe ser por lo menos de 12 caracteres"
    read -p "Presiona una tecla para continuar" opcion1
    clear
    echo " Nuevo Usuario "
    echo "---------------------- -----------------------------"
    read -p "Ingrese el nombre: " user
    user="${user}"
    read -p "Ingrese su contraseña: " pass
    pass="${pass}"

    
    if [ $((${#pass})) -gt $((11)) ];
    then
        echo ""
        # Descomentar la linea siguiente para agregar los usuarios
        #sudo useradd -p ${pass} ${user}
    else
        echo " La contraseña no puede ser menor a 12 caracteres"
    fi
    

    
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
            agregar_usuarios
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