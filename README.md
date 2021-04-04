# Setup

This distro helps me to get my setup back again if needed.

All steps here were done for Ubuntu.

Packages used:

* i3
  * playerctl
  * xcwd
  * rofi
  * picom
  * meson
  * ninja-build
  * lxappearance
  * gtk-chtheme
  * feh
  * xbacklight
  * touchpad script
  * fonts-awesome
  * bumblebee-status
* zsh
* oh-my-zsh
* vim-gtk
* plank

# Appearance

I use Ubuntu in two ways: using i3 window manager or using GNOME.

Most of the time I stick with i3, but for my classes I need GNOME to use the awesome
[Draw on Your Screen](https://extensions.gnome.org/extension/1683/draw-on-you-screen/) extension.

## Setting up i3

This configuration was largely based on the tutorial from Alex Booker.
You can watch it here [i3wm tutorial]
(https://www.youtube.com/watch?v=j1I63wGcvU4)

---

The first step is obviously getting i3. To do so open the terminal and type

`sudo apt-get install i3`

Logout, change the desktop environment to i3 (click on the ubuntu logo in the login
screen and select i3)

---
Important

I won't cover the configuration of colors and some other commands as they are basically
done by changing values in the i3 configuration file. Besides that, the documentation for i3 is incredibly good, if there is any doubt, just go to [i3 documentation](https://i3wm.org/) and search for what you need.

I will try to comment the dotfiles as much as I can to be easier to customize.

---
### Fixing keyboard media keys

The binding for the keyboard media keys are already set in the i3 configuration file,
we just need to install the dependencies.

For sound buttons:

`sudo apt-get install playerctl`

For screen brighteness:

`sudo apt-get install xbacklight`

### Fixing the touchpad for notebook

For that you will need this bash script

```
#!/bin/bash
if synclient -l | grep "TouchpadOff .*=.*0" ; then
    synclient TouchpadOff=1 ;
else
    synclient TouchpadOff=0 ;
fi
```

Create a file, paste this script, save it with the name `toggletouchpad.sh` in the `~/.scripts` folder

### Displaying a wallpaper image

In the i3 configuration file there is a line to set a wallpaper:

`exec_always feh --bg-scale /home/marcelo/Images/Wallpapers/pink-purple.jpg`

To change the wallpaper just alter the path to the image file.


But before we need to get the package *feh*. To install it:

`sudo apt-get install feh`

### Configuring multi-monitors layout

We could do this operation using `xrandr` but it's easier to just install a package called `arandr`. It's a tool that will generate all the `xranr` commands for us. To install it:

`sudo apt-get install arandr`

Open `arandr` and position the monitors as you wish. Apply and save the generated
.sh file. Open this file and paste it's contents, excluding the shebang, to the
i3 configuration file with the command `exec_always` preappend. Like this:

```
exec_always xrandr --output eDP-1 --mode 1366x768 --pos 1366x0 --rotate normal --output HDMI-1 --primary --mode 1366x768 --pos 0x0 --rotate normal --left-of eDP-1 --output DP-1 --off
```

### Setting icon fonts in i3

For this step just download and extract the font-awesome .ttf files into the `~/.font`
directory.

### Changing fonts

To change the system fonts, open the i3 configuration file and change the line

`font pango: some-font-name font-size`

to your desired font and size.

### Changing the GTK fonts

To change the GTK fonts, the easiest way is to use an application called *lxappearance*. Get it with:

`sudo apt-get install lxappearance`

Open it and choose the font you want.

### Changing the theme

Another thing that we can do with *lxappearance* is changing the system theme.
I really like Dracula so that is what I am going to use.

Just head over to [Dracula GTK](https://draculatheme.com/gtk) and download it.
Extract the files to ~/.themes and set it with *lxappearance*

Note: the Dracula theme came with the name **gtk-master** by default. So I manually
changed the folder name to Dracula to be clearer what I have selected.

Dracula also has an icon theme. To get it enter the same link above. Just download it, extract to `~/.icons` and then set
it with *lxappearance*

### Customizing lockscreen

i3 uses a (very!) simple lock screen. It's just a white screen that responds to user input with a big ugly circle in the middle.

To change that, the tutorial provides a link to a reddit post which you can access [here](https://www.reddit.com/r/unixporn/comments/3358vu/i3lock_unixpornworthy_lock_screen/)

In the comments someone provided a similar lock screen which works on multiple monitors. There were a few minor fixes that I needed to make before it worked: remove the "primary " word from the `grep` command output and to set the flag '-o' to the `scrop` command to overwrite old images.

Besides that I also prefer the blur background than the pixelated, so I changed that too. Finally I set the middle lock to be the Dracula logo.
### Changing DMenu - Rofi

i3 uses DMenu to quickly find an application that you need. A similar tool for that
is *Rofi*. *Rofi* is easier to customize allowing for further modifications. Install it with:

`sudo apt-get install rofi`

Inside .config folder, create another folder with the name 'rofi' and place the configuration file, **config.rasi**, there.

This customization is alot different than the one from Alex. I used the Dracula for reference and changed some of then to my own taste.

### Installing a compositor

The compositor that Alex uses is Coptom, but his repo is not maintained anymore. A fork of Coptom was created and received the name Picom.

To install Picom we will need to use Git

`git clone https://github.com/yshui/picom && cd picom`

cd to *Picom* folder and build it with meson and ninja.

For that run the following commands:

```
  git submodule update --init --recursive
  meson --buildtype=release . build
  ninja -C build
  ninja -C build install
```

To install meson and ninja in case you don't have it

`sudo apt install meson ninja-build`

### Configuring the blocks with bumblebee-status

In the tutorial i3blocks is used to change the status bar in i3. I prefer bumblebee-status

Just use the git command inside i3 configuration folder

`git clone git://github.com/tobi-wan-kenobi/bumblebee-status`


