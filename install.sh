#!/bin/bash

sudo apt-get -qq update
sudo apt-get -y -qq dist-upgrade

sudo apt-get -qq update
sudo apt-get -y -qq upgrade

mkdir .config/autostart/

###################################
# package management
# add all new packages here so we don't have to update so much
####################################
sudo apt-get install -y -qq pp-purge
sudo add-apt-repository -y ppa:pithos/ppa
sudo add-apt-repository -y ppa:otto-kesselgulasch/gimp
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository -y ppa:gnome3-team/gnome3

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee -a /etc/apt/sources.list
wget https://dl.google.com/linux/linux_signing_key.pub
sudo apt-key add linux_signing_key.pub

wget -q "http://deb.playonlinux.com/public.gpg" -O- | sudo apt-key add -

sudo apt-get -qq update

echo "
############################
#
# java
#
############################
"
# Has ppa. Delete that if you delete this
sudo apt-get purge -y -qq openjdk*
sudo apt-get update
sudo apt-get install -y -qq oracle-java8-installer


echo "
######################
#
# xmind 
#
######################
"
sudo dpkg -i ~/install/xmind*
sudo apt-get -y -qq install -f

echo "
######################
#
# install skype
#
######################
"
wget http://download.skype.com/linux/skype-ubuntu-precise_4.3.0.37-1_i386.deb
sudo dpkg -i skype*
sudo apt-get -y -qq install -f
rm skype*


echo "
######################
#
# vagrant on virtual box
#
######################
"
# wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_64.deb
# sudo apt-get -y -qq install virtualbox
# sudo dpkg -i vagrant*
# sudo apt-get -y -qq install -f
# rm vagrant*

echo "
#####################################
#
#   adb for managing the phone
#
#####################################
"
sudo apt-get install android-tools-adb
sudo apt-get install android-tools-fastboot

echo "
#####################################
#
#   development
#
#####################################
"
sudo apt-get install -y -qq git git-core bash-completion
sudo apt-get install -y -qq xclip
git config --global user.email "jtegwen@gmail.com"
git config --global user.name "Joelle Tegwen"
git config --global alias.st "status"
git config --global alias.co "checkout"
git config --global alias.br "branch"
git config --global alias.ci "commit"
git config --global core.editor "gedit"

echo "*~" > .gitignore
git config --global core.excludesfile ~/.gitignore

cd install 
git remote rename origin install
cd ~


echo "
######################
#
# pitch unwanted applications
#
######################
"
sudo apt-get -y -qq purge thunderbird shotwell evolution empathy 


echo "
#####################################
#
#   entertainment
#
#####################################
"
sudo apt-get install -y -qq nethack-common
sudo apt-get install -y -qq kshisen
# Has ppa delete that if you delete pithos
sudo apt-get install -y -qq pithos
sudo apt-get install -y -qq slack
# Has ppa delete that if you delete spotify
sudo apt-get install -y spotify-client
        

# Install Common Codecs And Enable DVD playback
# Is this still current? sudo apt-get install -y gstreamer0.10-plugins-ugly libxine1-ffmpeg gxine mencoder libdvdread4 totem-mozilla icedax tagtool easytag id3tool lame nautilus-script-audio-convert libmad0 mpg321 gstreamer1.0-libav

echo "
# Chromium and Chrome
"
sudo apt-get install -y -qq chromium-browser
# this has a new source. remove it from above if you remove from here. 
sudo apt install -y -qq google-chrome-stable


echo "
# photo management
"
sudo apt-get install -y -qq digikam
# Has ppa. Delete that if you delete gimp
sudo apt-get install -y -qq gimp gimp-data gimp-plugin-registry gimp-data-extras

sudo apt-get install -y -qq rar

echo "
# download videos from youtube
"
sudo wget https://yt-dl.org/latest/youtube-dl -O /usr/local/bin/youtube-dl
sudo chmod a+x /usr/local/bin/youtube-dl

echo "
# enable caffeine to keep the display from sleeping
"
sudo apt-get install -y -qq caffeine 
cp /usr/share/applications/caffeine-indicator.desktop ~/.config/autostart/

echo "
# flux for easy reading in the evening
"
sudo apt-get install -y fluxgui


echo "
###############################
#
# Cleanup
#
##############################
"
sudo apt-get -y -qq autoremove

echo "
###############################
#
# Configuration changes
#
##############################
"
#clean up old crash reports
sudo rm /var/crash/* 

# chrome-gnome shell itegration
sudo apt-get install -y -qq chrome-gnome-shell

# performance tweaks
sudo apt-get install -y -qq preload

sudo cp  /etc/sysctl.conf  /etc/sysctl.conf.bak
echo "#Decrease swap usage to a more reasonable level" | sudo tee -a  /etc/sysctl.conf
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf
echo "# Improve cache management" | sudo tee -a  /etc/sysctl.conf
echo "vm.vfs_cache_pressure=50" | sudo tee -a /etc/sysctl.conf


cd /etc/xdg/autostart/
sudo sed --in-place 's/NoDisplay=true/NoDisplay=false/g' *.desktop

# set my awesome wallpaper
gsettings set org.gnome.desktop.background picture-uri 'file:///home/joelle/Pictures/Wallpapers/blue-dragon.jpg'

# Setting tweaks 
# auto hide launcher
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode 1
#brightness and lock
gsettings set org.gnome.desktop.session idle-delay 30

#Show my name on the control pannel
gsettings set com.canonical.indicator.session show-real-name-on-panel true
# always show scrollbar
gsettings set com.canonical.desktop.interface scrollbar-mode normal

# custom key binding for xkill since I seem to need it a lot
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/' name "xkill"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/' command "xkill"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/' binding "'<Primary><Alt>x" 

#power settings
gsettings set org.gnome.settings-daemon.plugins.power cirtical-battery-action 'hibernate'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-action 'suspend'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout '1800'
gsettings set org.gnome.settings-daemon.plugins.power lid-close-ac-action 'suspend'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout '300'
gsettings set org.gnome.settings-daemon.plugins.power lid-close-bettery-action 'suspend'
gsettings set org.gnome.settings-daemon.plugins.power idle-brightness 900
gsettings set org.gnome.desktop.session idle-delay "uint32 1800"
gsettings set org.gnome.desktop.screensaver lock-delay "uint32 1800"



# update settings
gsettings set org.gnome.settings-daemon.plugins.updates frequency-get-updates 86400
gsettings set org.gnome.settings-daemon.plugins.updates frequency-get-updates 604800
gsettings set org.gnome.settings-daemon.plugins.updates notify-distro-upgrades true
gsettings set org.gnome.settings-daemon.plugins.updates frequency-updates-notification 604800



#stop online snooping and searching
wget -q -O - https://fixubuntu.com/fixubuntu.sh | bash

#custominze the launcher favorites for unity
gsettings set com.canonical.Unity.Launcher favorites "['application://nautilus.desktop', 'application://libreoffice-writer.desktop', 'application://libreoffice-calc.desktop', 'application://pithos.desktop', 'application://chromium-browser.desktop', 'application://firefox.desktop', 'application://xmind.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"


#####################################################
#manual stuff
#####################################################
echo ""
echo "#########################"
echo "Manual tasks"
echo "#########################"
echo "sudo gedit /etc/default/apport"
echo "set enabled to 0"
echo ""
echo "enable hibernate see: http://ubuntuhandbook.org/index.php/2014/10/enable-hibernate-option-in-ubuntu-14-10-unity/"
echo ""
echo ""





