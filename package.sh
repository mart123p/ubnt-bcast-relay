#!/usr/bin/env bash
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
export COPYFILE_DISABLE=true

VERSION=$(cat ./version)
NAME='ubnt_bcast_relay'
BCAST="${NAME}.${VERSION}."
INSTALL="install_${NAME}.v${VERSION}"
PAYLOAD='payload'
if [[ -e "${0##*/}" ]]; then
	BASEDIR="$(pwd)"
	mkdir -p ./build
	mkdir -p ./build/payload

	if [ ! -f ./build/udp-bcast-relay ]; then
		echo "Must run make before"
		exit 1
	fi
	cp -r ./src/${PAYLOAD} ./build

	mkdir -p ./build/payload/binaries
	cp ./build/udp-bcast-relay ./build/payload/binaries/
	cd ./build/payload/
	echo ${VERSION} > version
	tar zcf ../${PAYLOAD}.tgz --exclude='._*' --exclude='.svn' --exclude='.DS_Store' --exclude='*.bak' --exclude='*~' ./*
	cd ..

	if [[ -e ${PAYLOAD}.tgz ]]; then
		cat ../src/decompress.sh ${PAYLOAD}.tgz > ${INSTALL}
	else
		echo "${PAYLOAD}.tgz does not exist"
		exit 1
	fi

	chmod 0755 ${INSTALL}
	tar zcf ${INSTALL}.tgz ${INSTALL}
	# rm ${PAYLOAD}.tgz
	echo "${INSTALL} created"
else
	echo "$(basename $0) must be run in the directory where it is located."
fi
exit 0
