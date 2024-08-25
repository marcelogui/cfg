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