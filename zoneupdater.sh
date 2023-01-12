#!/bin/bash
DIRECTORY=/var/cache/bind
## Change this directory to support your distro
#	debian like : /var/cache/bind
#	redhat like : /var/nammed
synopsis () {
        echo "Utilisation :"
	echo -e "\tzone-updater.sh -z ZONE -f ZONE_FILE"
}

if [[ -z "$1" ]] ; then
        synopsis 
	exit
fi

while [[ -n "$1" ]]
        do
        case $1 in
		-z|--zone)
			zone="$2"
			shift 2
			;;
		-f|--file)
			cd "${DIRECTORY}"
			if [[ -f "${2##*/}" ]] ; then
			       	zone_file="${2##*/}"	
				shift 2
			else
				echo "file not found"
				exit 2
			fi
			;;
		*)
			echo "synthax error"
			exit 2
	esac
done
/usr/sbin/rndc freeze ${zone}
/usr/sbin/rndc sync -clean ${zone}
sed -i -E '/SOA/ N;s/(\n[^0-9]+)[0-9]+/\1'"$(grep -A 1 'SOA' ${DIRECTORY}/${zone_file} | awk  '/^\t/ {print $1+1}')"'/' ${DIRECTORY}/${zone_file}
vi ${DIRECTORY}/${zone_file}
if /usr/sbin/named-checkzone ${zone} ${DIRECTORY}/${zone_file} ; then
	/usr/sbin/rndc reload ${zone}
	/usr/sbin/rndc thaw ${zone}
else
	echo "erreur dans votre zone... relancer la procédure"
fi

