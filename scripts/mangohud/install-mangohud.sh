#!/bin/sh

if [ -f /usr/bin/apt ];then
	sudo apt install -y git ninja-build python3-pip gcc g++ meson python3 libxnvctrl-dev libdbus-1-dev libx11-dev libdrm-dev mesa-common-dev glslang-dev glslang-tools
	python3 -m pip install mako
elif [ -f /usr/bin/pacman ];then
	sudo pacman -S --needed git ninja gcc meson python-mako dbus libdrm glslang
fi



rm -rf ~/.tmp
mkdir ~/.tmp
cd ~/.tmp


git clone --recurse-submodules https://github.com/flightlessmango/MangoHud.git
cd MangoHud

meson build --prefix=/home/$USER/.tmp/MangoHud/res -Dwith_xnvctrl=disabled
ninja -C build install

sudo rm -rf /bin/mangohud /lib/libMangoHud.so /lib/libMangoHud_dlsym.so

sudo cp res/bin/mangohud /bin
sudo cp res/lib/mangohud/* /lib

rm -rf ~/.tmp


echo For vulkan games use \"mangohud\ \%game\%\" and for opengl games use \"mangohud --dlsym \%game\%\"
