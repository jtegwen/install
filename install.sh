#!/bin/bash
sudo apt-get update
sudo apt-get -y upgrade

# java
sudo apt-get purge -y openjdk*
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y -qq oracle-java7-installer

######################
# wuala 
######################
wget https://cdn.wuala.com/repo/deb/wuala_current_amd64.deb
sudo dpkg -i wuala* 
sudo apt-get -y -qq install -f
rm wuala* 


######################
# vagrant on virtual box
######################
wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_64.deb
sudo apt-get -y -qq install virtualbox
sudo dpkg -i vagrant*
sudo apt-get -y -qq install -f
rm vagrant*


#####################################
#   development
#####################################
sudo apt-get install -y -qq vim
sudo apt-get install -y -qq git git-core bash-completion


######################
# install chrome, pitch thunderbird
######################

sudo apt-get -y -qq install chromium-browser
sudo apt-get -y -qq purge thunderbird



###########################
# Postit notes

sudo add-apt-repository ppa:umang/indicator-stickynotes
sudo apt-get update
sudo apt-get install -y indicator-stickynotes

#####################################
#   entertainment
#####################################
sudo apt-get install -y -qq nethack-common
sudo apt-get install -y -qq kshisen
sudo add-apt-repository -y ppa:pithos/ppa && sudo apt-get update
sudo apt-get install -y -qq pithos
sudo apt-get install -y slack


# Install Common Codecs And Enable DVD playback
# Is this still current? sudo apt-get install -y gstreamer0.10-plugins-ugly libxine1-ffmpeg gxine mencoder libdvdread4 totem-mozilla icedax tagtool easytag id3tool lame nautilus-script-audio-convert libmad0 mpg321 gstreamer1.0-libav



# photo management
sudo apt-get install -y -qq digikam
sudo apt-get install -y -qq gimp gimp-data gimp-plugin-registry gimp-data-extras

sudo add-apt-repository ppa:otto-kesselgulasch/gimp && sudo apt-get update
sudo apt-get install gmic gimp-gmic

sudo apt-get install -y -qq rar

# download videos from youtube
sudo apt-get remove -y youtube-dl
sudo wget https://yt-dl.org/latest/youtube-dl -O /usr/local/bin/youtube-dl
sudo chmod a+x /usr/local/bin/youtube-dl

# performance tweaks
sudo apt-get install -y preload

sudo cp  /etc/sysctl.conf  /etc/sysctl.conf.bak
echo "#Decrease swap usage to a more reasonable level" | sudo tee -a  /etc/sysctl.conf
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf
echo "# Improve cache management" | sudo tee -a  /etc/sysctl.conf
echo "vm.vfs_cache_pressure=50" | sudo tee -a /etc/sysctl.conf


cd /etc/xdg/autostart/
sudo sed --in-place 's/NoDisplay=true/NoDisplay=false/g' *.desktop


# Setting tweaks 
# auto hide launcher
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode 1
#brightness and lock
gsettings set org.gnome.desktop.session idle-delay 30

#Show my name on the control bannel
gsettings set com.canonical.indicator.session show-real-name-on-panel true
# always show scrollbar
gsettings set com.canonical.desktop.interface scrollbar-mode normal

# autostart wuala on login
cp /usr/share/applications/wuala.desktop ~/.config/autostart/

# custom key binding for xkill since I seem to need it a lot
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/' name "xkill"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/' command "xkill"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/' binding "'<Primary><Alt>x" 

#don't show amazon results and other crap on search
gsettings set com.canonical.Unity.Lenses disabled-scopes "['more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope', 'more_suggestions-populartracks.scope', 'music-musicstore.scope', 'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope', 'more_suggestions-skimlinks.scope']"

#custominze the launcher favorites
gsettings set com.canonical.Unity.Launcher favorites "['application://nautilus.desktop', 'application://libreoffice-writer.desktop', 'application://libreoffice-calc.desktop', 'application://pithos.desktop', 'application://chromium-browser.desktop', 'application://firefox.desktop', 'application://xmind.desktop', 'unity://running-apps', 'application://wuala.desktop', 'unity://expo-icon', 'unity://devices']"





