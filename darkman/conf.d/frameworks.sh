#!/usr/bin/env sh

if [[ "$1" == 'dark' ]]; then
	#gsettings set org.gnome.desktop.interface color-scheme prefer-dark
	gsettings set org.gnome.desktop.interface gtk-theme Catppuccin-Macchiato-Standard-Blue-Dark
	sed -i 's|color_scheme_path=.*|color_scheme_path=/home/waka/.config/qt6ct/colors/Catppuccin-Macchiato.conf|' ~/.config/qt6ct/qt6ct.conf

	gsettings set org.gnome.desktop.interface cursor-theme Catppuccin-Macchiato-Dark-Cursors
elif [[ "$1" == 'light' ]]; then
	#gsettings set org.gnome.desktop.interface color-scheme prefer-light
	gsettings set org.gnome.desktop.interface gtk-theme Catppuccin-Latte-Standard-Blue-Light
	sed -i 's|color_scheme_path=.*|color_scheme_path=/home/waka/.config/qt6ct/colors/Catppuccin-Latte.conf|' ~/.config/qt6ct/qt6ct.conf

	gsettings set org.gnome.desktop.interface cursor-theme Catppuccin-Frappe-Light-Cursors
fi
