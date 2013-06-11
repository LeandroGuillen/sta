#! /bin/bash


function save(){
    fichero="/etc/asterisk/users.conf"
    echo "[$name]" >> $fichero
	echo "type=$typee" >> $fichero
	echo "secret=$secret" >> $fichero
	echo "nat=$nat" >> $fichero
	echo "host=$host" >> $fichero
	echo "context=$context" >> $fichero
	echo "transport=$transport" >> $fichero
	echo "encryption=$encryption" >> $fichero
	echo "srtpcapable=$capable" >> $fichero
	echo ";" >> $fichero
}

function addExtension(){
	
	original=/etc/asterisk/extensions.conf
	temporal=/etc/asterisk/extensions_temp.conf
	
	while read line
	do
		if [ "$line" == "[$context]" ]; then
			echo  $line >> $temporal
			echo  "exten => $extension,1,Set(_SIP_SRTP_SDES=optional)" >> $temporal
			echo  "exten => $extension,n,Dial(SIP/$name)" >> $temporal
		else
			echo $line >> $temporal
		fi
	done < $original
	
	# Eliminar el original
	rm $original
	# Cambiar el nombre al temporal
	mv $temporal $original
}


echo "-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
echo "* Este script añade un usuario al fichero /etc/asterisk/users.conf    *" 
echo "-  y añade una extension al fichero /etc/asterisk/extensions.conf.    -"
echo "*                                                                     *"
echo "- Se basa en el contexto del usuario y busca ese mismo contexto en    -" 
echo  "  extensions.conf para añadir la extension.                          *"  
echo "* La prioridad es 1 para todas las extensiones                        -"
echo "-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-"
echo ""

echo -n "name="
read name


echo -n "secret= "
read secret


echo -n "type [friend]= "
read typee

if [ "$typee" == "" ]; then
    typee="friend"
fi


echo -n "nat [no]= "
read nat

if [ "$nat" == "" ]; then
    nat="no"
fi


host="dynamic"
echo -n "host [dynamic]= "
read host

if [ "$host" == "" ]; then
    host="dynamic"
fi
	


echo -n "context [default]= "
read context

if [ "$context" == "" ]; then
    context="default"
fi

echo -n "transport [udp]= "
read transport

if [ "$transport" == "" ]; then
    transport="udp"
fi

echo -n "encryption [yes]= "
read encryption

if [ "$encryption" == "" ]; then
    encryption="yes"
fi

echo -n "srtpcapable [yes]= "
read capable

if [ "$capable" == "" ]; then
    capable="yes"
fi


# Añadir una extension para ese usuario y el contexto
echo -n "Indique la extensión del usuario: "
read extension


echo "Compruebe la informacion \n"

echo "      [$name]"
echo "      type=$typee"
echo "      secret=$secret"
echo "      nat=$nat"
echo "      host=$host"
echo "      context=$context"
echo "      transport=$transport"
echo "      encryption=$encryption"
echo "      srtpcapable=$capable"
echo "      extension $extension"

echo -n "¿Es correcta la informacion anterior? (s/n): "
read correcta

if [ "$correcta" == "s" ]; then
    save
    addExtension
    echo "Usuario $name añadido correctamente"
else
    echo "Usuario $name descartado"
fi

	


