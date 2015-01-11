#!/bin/bash

echo "COPYING PACMAN.CONF..."
cp --backup=numbered etc/pacman.conf /etc

echo "UPDATING PACKAGES LIST..."
pacman -Syu

echo "INSTALLING BASIC PACKAGES..."
pacman -S linux-firmware yaourt archey3 mlocate mc gvim-python3 git jre8-openjdk python python-pip python2 python2-pip ruby

echo "INSTALLING KDE PACKAGES..."
pacman -S kde-meta-kdebase kde-l10n-hu qtcurve-kde4 qtcurve-gtk2 kio-mtp kdemultimedia-kmix kde-gtk-config krusader krename kdegraphics-gwenview

echo "INSTALLING DESKTOP PACKAGES..."
pacman -S conky qalculate-gtk vlc firefox firefox-i18n-hu flashplugin

echo "INSTALLING CHROMIUM..."
pacman -S chromium

# TODO: switch to normal user.

# echo "INSTALLING AUR PACKAGES..."
# yaourt -S kawoken-icons
#
# echo "INSTALLING CHROMIUM PEPPER FLASH... (dont forget to enable in about:plugins)"
# yaourt -S chromium-pepper-flash
#
# echo "INSTALLING OTHER THINGS..."
# gem install bundler
