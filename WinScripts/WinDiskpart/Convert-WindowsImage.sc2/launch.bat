@echo off
set SDL_VIDEODRIVER=directx
set QEMU_AUDIO_DRV=dsound
set SDL_AUDIODRIVER=dsound
set QEMU_AUDIO_LOG_TO_MONITOR=1
rem #################################################
rem ## path to the program
set PATH=c:\progra~1\qemu
rem ## aarch64, alpha, arm, i386, m68k, mps, mips64, ppc, x86_64
set PLATFORM=i386
set EMULATOR=%PATH%\qemu-system-%PLATFORM%.exe
rem #################################################
rem ## The motherboard
set MACHINE=-M pc
rem ## The processor model
set CPU=-cpu max
rem ## [cpus=]n[,cores=cores][,threads=threads][,sockets=sockets][,maxcpus=maxcpus]
set SMP=-smp 4
set PROCESSOR=%CPU% %SMP%
rem ## Default is 128M - suffix of “M”egabytes or “G”igabytes
set MEMORY=-m 2G
rem ## BIOS
set BIOS=-bios
rem ## ROM
set BOOTROM=-option-rom
set SYSTEM=%MACHINE% %PROCESSOR% %MEMORY%
rem #################################################
set IMAGE=WindowsXP
set DFILE=%IMAGE%.img
rem ##  ide, scsi, sd, mtd, floppy, pflash, virtio, none.
set DIFACE=ide
rem ##  media: disk,cdrom
rem set DMEDIA=disk
rem ## format: ide, scsi, sd, mtd, floppy, pflash, virtio, none, qcow2
set DFORMAT=qcow2
set DRIVE=-drive file=%DFILE%,if=%DIFACE%,media=%DMEDIA%,format=%DFORMAT%
rem ## snapshoting
if not exist %DFILE% (
    rem CREATE a virtual hard disk 
    %PATH%\qemu-img.exe create -f qcow2 %DFILE% 32G
) else (
    rem set snapshot on after the first time 
	set DRIVE=%DRIVE%,snapshot=on -snapshot    
)
rem cdrom
set DRIVE=%DRIVE% -cdrom %IMAGE%.iso
rem #################################################
rem ## SecureDigital card image
set SDCARD=-sd
rem ## on-board flash memory
set BLOCK=-mtdblock
rem ## parrallel flash
set FLASH=-pflash
rem #################################################
rem ## extra devices
set %DEVICE%=-usb -usbdevice tablet
rem #################################################
rem ## [tap|bridge|user|l2tpv3|vde|netmap|vhost-user|socket|nic][,mac=macaddr][,model=mn]
set NTYPE=-device pcnet,netdev=netdev0
rem ## user,tap,bridge,socket,l2tpv3,vde,vhost-user,hubport
set NDEV=-netdev tap,id=netdev0,ifname=TAP
set NETWORK=%NTYPE% %NDEV%
rem #################################################
rem ## device tree to pass to kerel
set DEVBIN=-dtb 
rem ## kernel or multiboot
set KERNEL=-kernel
rem ## initial ram disk can add arg=
set INITRD=-initrd 
rem ## kernel command line
set APPEND=
rem this skips normal booting and loads kernel and mounts drive
set %LINUXBOOT%=%KERNEL% %INITRD% %DEVBIN% %APPEND%
rem #################################################
rem ## display sdl,curses,none,gtk,vnc. -nographic -full-screen
rem set DISPLAY=-display vnc=:0
set DISPLAY=-display gtk
rem ##
set SERIALOUT=-serial stdio
rem 
set %DEBUG%=-monitor stdio
rem #################################################
set COMMANDLINE=%EMULATOR% %SYSTEM% %DISPLAY% %SERIALOUT% %DRIVE% %NETWORK% %DEVICE% %DEBUG%
echo %COMMANDLINE% 
start %COMMANDLINE%
rem start c:\progra~1\\TightVNC\tvnviewer.exe :5900
