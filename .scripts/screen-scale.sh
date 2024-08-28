#!/bin/bash

if xrandr | grep "eDP-1" ; then
    xrandr --output eDP-1 --scale 2;
fi
