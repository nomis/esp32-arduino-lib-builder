#/bin/bash

source ./tools/config.sh

CAMERA_REPO_URL="https://github.com/espressif/esp32-camera.git"
DL_REPO_URL="https://github.com/espressif/esp-dl.git"
SR_REPO_URL="https://github.com/espressif/esp-sr.git"
RMAKER_REPO_URL="https://github.com/espressif/esp-rainmaker.git"
DSP_REPO_URL="https://github.com/espressif/esp-dsp.git"
LITTLEFS_REPO_URL="https://github.com/joltwallet/esp_littlefs.git"
TINYUSB_REPO_URL="https://github.com/hathach/tinyusb.git"

#
# CLONE/UPDATE ARDUINO
#

if [ ! -d "$AR_COMPS/arduino" ]; then
	git clone $AR_REPO_URL "$AR_COMPS/arduino"
fi

git -C "$AR_COMPS/arduino" fetch && \
git -C "$AR_COMPS/arduino" checkout 2.0.3
if [ $? -ne 0 ]; then exit 1; fi

#
# CLONE/UPDATE ESP32-CAMERA
#

if [ ! -d "$AR_COMPS/esp32-camera" ]; then
	git clone $CAMERA_REPO_URL "$AR_COMPS/esp32-camera"
else
	git -C "$AR_COMPS/esp32-camera" fetch
fi && \
git -C "$AR_COMPS/esp32-camera" checkout 86a4951
#this is a temp measure to fix build issue in recent IDF master
if [ -f "$AR_COMPS/esp32-camera/idf_component.yml" ]; then
	rm -rf "$AR_COMPS/esp32-camera/idf_component.yml"
fi
if [ $? -ne 0 ]; then exit 1; fi

#
# CLONE/UPDATE ESP-DL
#

if [ ! -d "$AR_COMPS/esp-dl" ]; then
	git clone $DL_REPO_URL "$AR_COMPS/esp-dl"
else
	git -C "$AR_COMPS/esp-dl" fetch
fi && \
git -C "$AR_COMPS/esp-dl" checkout d949350
if [ $? -ne 0 ]; then exit 1; fi

#
# CLONE/UPDATE ESP-SR
#

if [ ! -d "$AR_COMPS/esp-sr" ]; then
	git clone $SR_REPO_URL "$AR_COMPS/esp-sr"
else
	git -C "$AR_COMPS/esp-sr" fetch
fi && \
git -C "$AR_COMPS/esp-sr" checkout d05cf97
if [ $? -ne 0 ]; then exit 1; fi

#
# CLONE/UPDATE ESP-LITTLEFS
#

if [ ! -d "$AR_COMPS/esp_littlefs" ]; then
	git clone $LITTLEFS_REPO_URL "$AR_COMPS/esp_littlefs" && \
    git -C "$AR_COMPS/esp_littlefs" submodule update --init --recursive
else
	git -C "$AR_COMPS/esp_littlefs" fetch && \
    git -C "$AR_COMPS/esp_littlefs" submodule update --init --recursive
fi && \
git -C "$AR_COMPS/esp_littlefs" checkout 29341d0
if [ $? -ne 0 ]; then exit 1; fi

#
# CLONE/UPDATE ESP-RAINMAKER
#

if [ ! -d "$AR_COMPS/esp-rainmaker" ]; then
    git clone $RMAKER_REPO_URL "$AR_COMPS/esp-rainmaker" && \
    git -C "$AR_COMPS/esp-rainmaker" submodule update --init --recursive
    # git -C "$AR_COMPS/esp-rainmaker" checkout f1b82c71c4536ab816d17df016d8afe106bd60e3
else
	git -C "$AR_COMPS/esp-rainmaker" fetch && \
    git -C "$AR_COMPS/esp-rainmaker" submodule update --init --recursive
fi && \
git -C "$AR_COMPS/esp-rainmaker" checkout f57a5ec
if [ $? -ne 0 ]; then exit 1; fi

#
# CLONE/UPDATE ESP-DSP
#

if [ ! -d "$AR_COMPS/esp-dsp" ]; then
	git clone $DSP_REPO_URL "$AR_COMPS/esp-dsp"
	# cml=`cat "$AR_COMPS/esp-dsp/CMakeLists.txt"`
	# echo "if(IDF_TARGET STREQUAL \"esp32\" OR IDF_TARGET STREQUAL \"esp32s2\" OR IDF_TARGET STREQUAL \"esp32s3\")" > "$AR_COMPS/esp-dsp/CMakeLists.txt"
	# echo "$cml" >> "$AR_COMPS/esp-dsp/CMakeLists.txt"
	# echo "endif()" >> "$AR_COMPS/esp-dsp/CMakeLists.txt"
else
	git -C "$AR_COMPS/esp-dsp" fetch
fi && \
git -C "$AR_COMPS/esp-dsp" checkout 07aa7b1
if [ $? -ne 0 ]; then exit 1; fi

#
# CLONE/UPDATE TINYUSB
#

if [ ! -d "$AR_COMPS/arduino_tinyusb/tinyusb" ]; then
	git clone $TINYUSB_REPO_URL "$AR_COMPS/arduino_tinyusb/tinyusb"
else
	git -C "$AR_COMPS/arduino_tinyusb/tinyusb" fetch
fi && \
git -C "$AR_COMPS/arduino_tinyusb/tinyusb" checkout b5a9537eea81bd6ffd8d575dbd2b5823c2fc1f0e
if [ $? -ne 0 ]; then exit 1; fi

