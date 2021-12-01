
#!/bin/bash
# Bash Menu Script Example
# Funcion para leer los usuarios por nombre y apellidos.

menu () {
    clear
    echo "--Menu--"
        for ((i=1;i<8;i++));
        do
            echo "$i) ${options[i-1]}"
        done
}

agregar_usuarios () {
    echo "---------------------------------------------------"
    echo "La contraseña del nuevo usuario debe ser por lo menos de 12 caracteres"
    read -p "Presiona una tecla para continuar" opcion1
    clear
    echo "Nuevo Usuario"
    echo "---------------------------------------------------"
    read -p "Ingrese el nombre: " user
    user="${user}"
    read -p "Ingrese su contraseña: " pass
    pass="${pass}"

    
    if [ $((${#pass})) -gt $((11)) ];
    then
        # Descomentar la linea siguiente para agregar los usuarios
        sudo useradd -p ${pass} $user
        echo "Usuario agregado correctamente"
    else
        echo "La contraseña no puede ser menor a 12 caracteres"
    fi
    

    
    read -p "Presiona una tecla para continuar" opcion1
    clear
}

volcar_archivo () {
    clear
	echo "Ultimas acciones del Usuario"
	read -p "Ingrese el id de Usuario: " userId
	if id -nu "$userId" > /dev/null; then
		sudo -s cat /var/log/syslog | grep uid=$id > /home/$(whoami)/scriptShell/acciones.txt
		echo "Operación completada con éxito"
	fi
    read -p "Presiona una tecla para continuar" opcion1
    clear
}

sesion_fallida () {
    clear
    echo "Lista de usuarios que intentaron entrar con contraseña erronea"
    cat /var/log/auth.log | grep 'authentication failure'
    read -p "Presiona una tecla para continuar" opcion1
    clear
}

permiso_tecnico () {
    clear
    echo "Agregar Tecnicos"
    echo ""
    echo "---------------------------------------------------"
    read -p "Ingrese el Tecnico1: " user
    read -p "Ingrese su contraseña: " pass

    # descomentar las siguientes lineas esto puede ser peligroso para el sistema

    sudo useradd -p $pass $user
    sudo usermod -G root $user


    read -p "Ingrese el Tecnico2: " user
    read -p "Ingrese su contraseña: " pass

    # descomentar las siguientes lineas esto puede ser peligroso para el sistema
    sudo useradd -p $pass $user
    sudo usermod -G root $user
    read -p "Presiona una tecla para continuar" opcion1
    clear
}

deshabilitar_servicio(){
    echo ""
    read -p "Ingrese el nombre del tecnico: " user
    if  grep 'x:0:' /etc/group | grep -q $user; then
        sudo systemctl list-unit-files --type service --all
        read -p "Ingrese el nombre del servicio que deseas detener: " service
        sudo -u $user systemctl disable $service
        read -p "Presiona una tecla para continuar" opcion1
        sudo systemctl list-unit-files --type service --all
        ead -p "Presiona una tecla para continuar" opcion1
    else
       echo "El usuario no tiene permisos suficientes"
    fi
}

clear
PS3='Seleccione una opcion valida:  '
options=("Agregar Usuario" "Optener ultimas acciones de un usuario" "Mostrar usuarios que intentaron iniciar sesión con contraseña erronea" "Agregar tecnicos" "Deshabilitar servicio" "Mostrar los accesos de los usuarios al sistema, que sean el root" "Quit")
echo "--Menu--"
select opt in "${options[@]}"
do
    case $opt in
        "Agregar Usuario")
            agregar_usuarios
            menu
            ;;
        "Optener ultimas acciones de un usuario")
            volcar_archivo
            menu
            ;;
        "Mostrar usuarios que intentaron iniciar sesión con contraseña erronea")
            sesion_fallida
            menu
            ;;
        "Agregar tecnicos")
            permiso_tecnico
            menu
            ;;
        "Deshabilitar servicio")
            deshabilitar_servicio
            menu
            ;;
        "Mostrar los accesos de los usuarios al sistema, que sean el root")
            echo "Lista de usuarios que son root"
            grep 'x:0:' /etc/group
            read -p "Presiona una tecla para continuar" opcion1
            menu
            ;;
        "Quit")
            clear
            break
            ;;
        *) 
            clear
            echo "La opcion $REPLY es invalida"
            menu
            ;;
    esac
done
