docker: android-x86_64-5.1-rc1.img
	sudo docker build . -t quay.io/quamotion/android-x86-base:5.1-rc1

android-x86_64-5.1-rc1.img:
	wget -nc https://osdn.net/dl/android-x86/android-x86_64-5.1-rc1.img -O android-x86_64-5.1-rc1.img

run:
	sudo docker run --rm -it quay.io/quamotion/android-x86-base:5.1-rc1 /bin/bash
