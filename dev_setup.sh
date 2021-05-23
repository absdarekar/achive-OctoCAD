#!/usr/bin/env bash
# Script to install required softwares and libraries for development of OctoCAD
# Operating System: Ubuntu 20.04 LTS
# author: Atharv Darekar

FREECAD_DESKTOP_LAUNCHER_DIR="$HOME/.local/share/applications"
LOCAL_BIN_DIR="$HOME/.local/bin"
mkdir $HOME/OctoCAD
OCTOCAD_DIR="$HOME/OctoCAD"
OCTOCAD_DESKTOP_LAUNCHER_DIR="$HOME/.local/share/applications"

FREECAD_APPIMAGE="https://github.com/FreeCAD/FreeCAD/releases/download/0.18.4/FreeCAD_0.18-16146-rev1-Linux-Conda_Py3Qt5_glibc2.12-x86_64.AppImage"

echo ">>> Enable universe repository and update package information"
sudo add-apt-repository universe && sudo apt-get update

echo ">>> Install Git, GNU Octave, octave-symbolic package, pip3, Qt 5 Designer"
sudo apt-get install git octave octave-symbolic python3-pip qtcreator

echo ">>> Install PyQt5, pyqt5-tools and PySide2"
pip3 install PyQt5 pyqt5-tools PySide2

echo ">>> Clone OctoCAD official repository"

git clone https://github.com/absdarekar/OctoCAD.git $OCTOCAD_DIR
chmod +x $OCTOCAD_DIR/bin/Octocad.py

echo ">>> Create desktop launcher"
{
  echo "[Desktop Entry]"
  echo "Version=0.0.0"
  echo "Type=Application"
  echo "Terminal=false"
  echo "Name[en_IN]=OctoCAD"
  echo "Exec=$HOME/OctoCAD/bin/Octocad.py"
  echo "Name=OctoCAD"
  echo "Icon=$HOME/OctoCAD/icon/logo.png"
}>>"$OCTOCAD_DESKTOP_LAUNCHER_DIR/OctoCAD.desktop"
chmod -x "$OCTOCAD_DESKTOP_LAUNCHER_DIR/OctoCAD.desktop"

echo ">>> Download and setup FreeCAD 0.18.4 executable"
wget -O "$LOCAL_BIN_DIR/freecad" "$FREECAD_APPIMAGE"
chmod +x "$LOCAL_BIN_DIR/freecad"

echo ">>> Create desktop launcher for FreeCAD 0.18.4"
{
  echo "[Desktop Entry]"
  echo "Version=0.18.4"
  echo "Type=Application"
  echo "Terminal=false"
  echo "Name[en_IN]=FreeCAD"
  echo "Exec=$HOME/.local/bin/freecad"
  echo "Name=FreeCAD"
  echo "Icon=$HOME/OctoCAD/icon/freecad.png"
}>>"$FREECAD_DESKTOP_LAUNCHER_DIR/FreeCAD.desktop"
chmod -x "$FREECAD_DESKTOP_LAUNCHER_DIR/FreeCAD.desktop"

echo ">>> Done"
