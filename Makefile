docker: android-x86-4.4-r5.iso
	sudo docker build . -t quay.io/quamotion/android-x86-base:4.4-r5

android-x86-4.4-r5.iso:
	wget -nc https://osdn.net/dl/android-x86/android-x86-4.4-r5.iso -O android-x86-4.4-r5.iso

run:
	sudo docker run --rm -it quay.io/quamotion/android-x86-base:4.4-r5 /bin/bash
