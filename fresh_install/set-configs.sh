#!/bin/zsh



# fix cedila "ć"
if ! grep -q '^GTK_IM_MODULE=cedilla$' /etc/environment; then
    echo "GTK_IM_MODULE=cedilla" >> /etc/environment
    echo "Added GTK_IM_MODULE=cedilla to /etc/environment"
else
    echo "GTK_IM_MODULE=cedilla is already present in /etc/environment"
fi

if ! grep -q '^QT_IM_MODULE=cedilla$' /etc/environment; then
    echo "QT_IM_MODULE=cedilla" >> /etc/environment
    echo "Added QT_IM_MODULE=cedilla to /etc/environment"
else
    echo "QT_IM_MODULE=cedilla is already present in /etc/environment"
fi

# add support for touchpad navigation
sudo mkdir -p /etc/X11/xorg.conf.d && sudo tee <<'EOF' /etc/X11/xorg.conf.d/90-touchpad.conf 1> /dev/null
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
        Option "NaturalScrolling" "on"
        Option "ScrollMethod" "twofinger"
        Option "TappingButtonMap" "lrm"
EndSection

EOF
