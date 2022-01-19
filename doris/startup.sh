#!/bin/bash

set -e

initFe(){
    echo "start doris fe"
    [ -d "${FE_META}" ] || mkdir -p ${FE_META}
    sed -i "s|^[[:space:]]*\$LIMIT \$JAVA \$JAVA_OPTS org.apache.doris.PaloFe.*|    exec \$LIMIT \$JAVA \$JAVA_OPTS org.apache.doris.PaloFe \${HELPER} \"\$@\"|g" ${DORIS_HOME}/fe/bin/start_fe.sh
    echo "priority_networks = ${FE_NETWORK}" >> ${DORIS_HOME}/fe/conf/fe.conf
    echo "meta_dir = ${FE_META}" >> ${DORIS_HOME}/fe/conf/fe.conf
    exec bash ${DORIS_HOME}/fe/bin/start_fe.sh
}

initBe(){
    echo "start doris be"
    [ -d "${BE_DATA}" ] || mkdir -p ${BE_DATA}
    sed -i "s@^storage_root_path.*@storage_root_path = ${DORIS_HOME}/be/data@g" ${DORIS_HOME}/be/conf/be.conf
    echo "priority_networks = ${BE_NETWORK}" >> ${DORIS_HOME}/be/conf/be.conf
    echo "storage_root_path = ${BE_DATA}" >> ${DORIS_HOME}/be/conf/be.conf
    sed -i "s|^[[:space:]]*\$LIMIT \${DORIS_HOME}/lib/palo_be.*|    exec \$LIMIT \${DORIS_HOME}/lib/palo_be \"\$@\"|g" ${DORIS_HOME}/be/bin/start_be.sh

    #ENV FE_HOST, add be to fe
    #ENV BE_HOST
    COUNT=$(mysql -h${FE_HOST} -P9030 -uroot -e"SHOW PROC '/backends'\G;" | grep ${BE_HOST} | wc -l)
    if [ $COUNT -lt 1  ];
    then
        mysql -h${FE_HOST} -P9030 -uroot -e"ALTER SYSTEM ADD BACKEND \"${BE_HOST}:9050\";"
    fi
    exec bash ${DORIS_HOME}/be/bin/start_be.sh
}

printUsage() {
    echo -e "Usage: [ fe | be ]\n"
    printf "%-13s:  %s\n" "fe" "Doris master."
    printf "%-13s:  %s\n" "be" "Doris worker."
}

case "$1" in
    (fe)
        initFe
    ;;
    (be)
        initBe
    ;;
    (help)
        printUsage
        exit 1
    ;;
    (*)
        printUsage
        exit 1
    ;;
esac


