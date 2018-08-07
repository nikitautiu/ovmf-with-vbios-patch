#! /bin/bash 

echo "Starting VM" 

sudo /usr/bin/kvm-spice \
-name guest=win10-2,debug-threads=on \
-machine pc-q35-2.11,accel=kvm,usb=off,vmport=off,dump-guest-core=off \
-cpu Skylake-Client,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=0x1fff,hv_vendor_id=5DIE45JG7EAY,kvm=off \
-drive file=/home/marcosscriven/Downloads/build/OVMF_CODE.fd,if=pflash,format=raw,unit=0,readonly=on \
-drive file=/home/marcosscriven/Downloads/build/OVMF_VARS.fd,if=pflash,format=raw,unit=1 \
-m 4096 \
-realtime mlock=off \
-smp 4,maxcpus=8,sockets=8,cores=1,threads=1 \
-uuid e7d44285-507b-48da-bfe2-2eba415016bd \
-smbios 'type=0,vendor=Dell Inc.,version=1.9.4,date=04/23/2018,release=1.9' \
-smbios 'type=1,manufacturer=Dell Inc.,product=Precision 5520,version=Not Specified,serial=DWTG4Q2,sku=07BF,family=Precision' \
-smbios 'type=2,manufacturer=Dell Inc.,product=0R6JFH,version=A00,serial=/DWTG4Q2/CNCMK0086E027C/,asset=Not Specified,location=Not Specified' \
-no-user-config \
-nodefaults \
-rtc base=utc,driftfix=slew \
-global kvm-pit.lost_tick_policy=delay \
-no-hpet \
-no-shutdown \
-global ICH9-LPC.disable_s3=1 \
-global ICH9-LPC.disable_s4=1 \
-boot menu=on,strict=on \
-device ioh3420,port=0x1,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x1 \
-device pcie-root-port,port=0x9,chassis=2,id=pci.2,bus=pcie.0,addr=0x1.0x1 \
-device pcie-root-port,port=0xa,chassis=3,id=pci.3,bus=pcie.0,addr=0x1.0x2 \
-device pcie-root-port,port=0xb,chassis=4,id=pci.4,bus=pcie.0,addr=0x1.0x3 \
-device pcie-root-port,port=0xc,chassis=5,id=pci.5,bus=pcie.0,addr=0x1.0x4 \
-device pcie-root-port,port=0xd,chassis=6,id=pci.6,bus=pcie.0,addr=0x1.0x5 \
-device i82801b11-bridge,id=pci.7,bus=pcie.0,addr=0x1e \
-device pci-bridge,chassis_nr=8,id=pci.8,bus=pci.7,addr=0x0 \
-device ich9-usb-ehci1,id=usb,bus=pcie.0,addr=0x1d.0x7 \
-device ich9-usb-uhci1,masterbus=usb.0,firstport=0,bus=pcie.0,multifunction=on,addr=0x1d \
-device ich9-usb-uhci2,masterbus=usb.0,firstport=2,bus=pcie.0,addr=0x1d.0x1 \
-device ich9-usb-uhci3,masterbus=usb.0,firstport=4,bus=pcie.0,addr=0x1d.0x2 \
-device virtio-serial-pci,id=virtio-serial0,bus=pci.3,addr=0x0 \
-drive file=/home/marcosscriven/Downloads/Win10_1803_English_x64.iso,format=raw,if=none,id=drive-sata0-0-0,media=cdrom,readonly=on \
-device ide-cd,bus=ide.0,drive=drive-sata0-0-0,id=sata0-0-0,bootindex=1 \
-drive file=/var/lib/libvirt/images/win10-2-2.qcow2,format=qcow2,if=none,id=drive-sata0-0-2 \
-device ide-hd,bus=ide.2,drive=drive-sata0-0-2,id=sata0-0-2,bootindex=2 \
-device usb-tablet,id=input0,bus=usb.0,port=1 \
-spice port=5901,addr=127.0.0.1,disable-ticketing,seamless-migration=on \
-device virtio-vga,id=video0,max_outputs=1,bus=pci.2,addr=0x0 \
-device usb-audio,id=sound0,bus=usb.0,port=2 \
-chardev spicevmc,id=charredir0,name=usbredir \
-device usb-redir,chardev=charredir0,id=redir0,bus=usb.0,port=3 \
-chardev spicevmc,id=charredir1,name=usbredir \
-device usb-redir,chardev=charredir1,id=redir1,bus=usb.0,port=4 \
-device virtio-balloon-pci,id=balloon0,bus=pci.5,addr=0x0 \
-device vfio-pci,host=01:00.0,bus=pci.1,addr=00.0,x-pci-sub-device-id=4136,x-pci-sub-vendor-id=1983,multifunction=on \
-netdev tap,fd=22,id=hostnet0 \
-device rtl8139,netdev=hostnet0,id=net0,mac=52:54:00:50:41:60,bus=pci.8,addr=0x1 \
-msg timestamp=on 