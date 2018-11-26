docker: android-x86_64-6.0-r3.iso
	sudo docker build . -t quay.io/quamotion/android-x86-base:7.0-r3

android-x86_64-6.0-r3.iso:
	wget -nc https://osdn.net/dl/android-x86/android-x86_64-6.0-r3.iso -O android-x86_64-6.0-r3.iso

run:
	sudo docker run --rm -it quay.io/quamotion/android-x86-base:6.0-r3 /bin/bash
