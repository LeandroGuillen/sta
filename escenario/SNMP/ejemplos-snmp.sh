
#################### Ejemplos de comandos SNMP ####################


# Si no funciona el snmpwalk
# 1) Comprobar que en /etc/asterisk/res_snmp.o esta el enabled=yes
# 2) hacer export MIBS+=ASTERISK-MIB en la consola
# 3) reiniciar ASTERISK y el snmpd 


# Hacer esto en la consola para que funcione net snmp

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# Lanzar servidor snmpd.conf

	snmpd -r -u antonio -f -Leo -c $HOME/snmpd.conf udp:161 tlstcp:10161 dtlsudp:10161

# Lanzar servidor traps/informs

	snmptrapd -f -Leo -c $HOME/snmptrapd.conf

# Consultas v2

	snmpwalk -v2c -c rocom agente.com asterisk

    snmptable  -v2c -c rwcom    -Cl -CB -Ci -OX -Cb -Cc 16 -Cw 64   agente.com  ifTable

    snmpgetnext -v2c -c rocom  agente.com ifTable.0

# Consultas v3 con USM

	snmpwalk -v3 -u antonioro -n "" -l authNoPriv -a MD5 -A "antoniovl" -E 800000020109840301 agente.com asterisk
  
    snmptable  -v3 -a MD5 -u antonioro -A "antoniovl" -l authNoPriv   -Cl -CB -Ci -OX -Cb -Cc 16 -Cw 64   agente.com  ifTable

    snmpgetnext  -v3 -a MD5 -u antonioro -A "antoniovl" -l authNoPriv  agente.com  ifTable.0

    snmpinform -v3 -u antonioinform -a MD5 -A "antoniovl" -l authNoPriv manejador.com '' system.sysLocation.0

# Consultas v3 con  TSM

	snmpwalk -v3 -Dcert --defSecurityModel=tsm -u antonio -n "" -l authPriv -E 800000020109840301  -T localCert=EB:58:59:0C:3D:3E:E0:6F:0C:E1:7F:A0:36:47:1B:56:2B:5A:6F:BE  -T peerCert=82:22:B6:21:08:09:3E:41:C2:78:85:66:EE:D5:63:C7:A0:43:5E:8D tlstcp:agente.com:10161 asterisk


	snmptable -v3 -Dcert --defSecurityModel=tsm -u antonio -n "" -l authPriv -E 800000020109840301  -T localCert=EB:58:59:0C:3D:3E:E0:6F:0C:E1:7F:A0:36:47:1B:56:2B:5A:6F:BE  -T peerCert=82:22:B6:21:08:09:3E:41:C2:78:85:66:EE:D5:63:C7:A0:43:5E:8D -Ci -OX -Cb -Cc 5 -Cw 64 tlstcp:agente.com:10161 ifTable




