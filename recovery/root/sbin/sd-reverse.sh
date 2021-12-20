#!/sbin/sh

#############################################
CHANNEL=sd_msm808
EXE_PATH=/sbin/
#############################################

##echo 38 > /sys/class/gpio/export
##echo out > /sys/class/gpio/gpio38/direction
##echo 1 > /sys/class/gpio/gpio38/value

##echo 63 > /sys/class/gpio/export
##echo out > /sys/class/gpio/gpio63/direction 
##echo 1 > /sys/class/gpio/gpio63/value

##echo "peripheral" > /sys/devices/platform/soc/7000000.ssusb/mode
disable_sdcarplay=`getprop persist.sdcarplay.reverse.disable`
if [ $disable_sdcarplay = "1" ];then
setprop persist.vendor.usb.config "diag,serial_cdev,rmnet,dpl,adb"
setprop sys.qcom.main.start 1
setprop system.qcom.main.start 1
adb.sh
while true
do
	sleep 2
done
fi

setprop persist.vendor.usb.config "appleSvcTemp"
insmod /lib/modules/usb_f_sd_ptp.ko
insmod /lib/modules/usb_f_sd_hid.ko
insmod /lib/modules/usb_f_sd_mux.ko
insmod /lib/modules/usb_f_sd_uac1.ko
insmod /lib/modules/usb_f_sd_vsc.ko
insmod /lib/modules/snd-aloop.ko

mkdir /config/usb_gadget/g1/functions/ptp_sd.usb0
mkdir /config/usb_gadget/g1/functions/audio_sd.usb0
mkdir /config/usb_gadget/g1/functions/hid_sd.usb0
mkdir /config/usb_gadget/g1/functions/mux_sd.usb0
mkdir /config/usb_gadget/g1/functions/vsc_sd.usb0
mkdir /config/usb_gadget/g1/configs/b.2 0770
mkdir /config/usb_gadget/g1/configs/b.2/strings/0x409 0770
mkdir /config/usb_gadget/g1/configs/b.3 0770
mkdir /config/usb_gadget/g1/configs/b.3/strings/0x409 0770
mkdir /config/usb_gadget/g1/configs/b.4 0770
mkdir /config/usb_gadget/g1/configs/b.4/strings/0x409 0770

echo "86364000">/proc/sys/net/core/rmem_max
echo '1' > /config/usb_gadget/g1/configs/b.1/MaxPower

export LD_LIBRARY_PATH=/cache/suding_libs

$EXE_PATH/sd_mdnsd&
$EXE_PATH/sdCarplaySvc -c $CHANNEL

