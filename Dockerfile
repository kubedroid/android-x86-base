FROM quay.io/quamotion/android-x86-tools

ENV ISO_URL=https://osdn.net/dl/android-x86/android-x86_64-5.1-rc1.img
ENV ISO_FILE=android-x86_64-5.1-rc1.img

WORKDIR /android

# Download the ISO file. You can cache this file locally, to save
# bandwidth
# We don't need the Dockerfile, but COPY fails if there are no files
# to copy (e.g. the iso file doesn't exist). Adding the Dockerfile
# to keep the command happy.
COPY *.img Dockerfile ./
RUN if [ ! -f $ISO_FILE ]; then wget -nc $ISO_URL -O $ISO_FILE; fi \
#
# Extract the root file system
#
&& fatcat $ISO_FILE -O $((2048 * 512)) -r /SYSTEM.SFS > system.sfs \
&& unsquashfs -f -d . system.sfs system.img \
&& mkdir system \
&& ext2rd system.img ./:system \
&& rm -rf system/lost+found \
&& rm -rf system.sfs system.img \
#
# Extract the initrd image
#
&& fatcat $ISO_FILE -O $((2048 * 512)) -r /INITRD.IMG > initrd.img \
&& mkdir initrd \
&& (cd initrd && zcat ../initrd.img | cpio -idv) \
&& rm initrd.img \
#
# Extract the ramdisk image
#
&& fatcat $ISO_FILE -O $((2048 * 512)) -r /RAMDISK.IMG > ramdisk.img \
&& mkdir ramdisk \
&& (cd ramdisk && zcat ../ramdisk.img | cpio -idv) \
&& rm ramdisk.img \
#
# Extract the kernel
#
&& fatcat $ISO_FILE -O $((2048 * 512)) -r /KERNEL > kernel \
#
# Remove the ISO file
#
&& rm $ISO_FILE
