#/bin/bash

source ./tools/config.sh

CAMERA_REPO_URL="https://github.com/espressif/esp32-camera.git"
DL_REPO_URL="https://github.com/espressif/esp-dl.git"
SR_REPO_URL="https://github.com/espressif/esp-sr.git"
RMAKER_REPO_URL="https://github.com/espressif/esp-rainmaker.git"
INSIGHTS_REPO_URL="https://github.com/espressif/esp-insights.git"
DSP_REPO_URL="https://github.com/espressif/esp-dsp.git"
LITTLEFS_REPO_URL="https://github.com/joltwallet/esp_littlefs.git"
TINYUSB_REPO_URL="https://github.com/hathach/tinyusb.git"

#
# CLONE/UPDATE ARDUINO
#
echo "Updating ESP32 Arduino..."
if [ ! -d "$AR_COMPS/arduino" ]; then
	git clone $AR_REPO_URL "$AR_COMPS/arduino"
fi

git -C "$AR_COMPS/arduino" fetch && \
git -C "$AR_COMPS/arduino" checkout 2.0.6
if [ $? -ne 0 ]; then exit 1; fi

#
# CLONE/UPDATE ESP32-CAMERA
#
echo "Updating ESP32 Camera..."
if [ ! -d "$AR_COMPS/esp32-camera" ]; then
	git clone $CAMERA_REPO_URL "$AR_COMPS/esp32-camera"
else
	git -C "$AR_COMPS/esp32-camera" fetch
fi
if [ $? -ne 0 ]; then exit 1; fi
#this is a temp measure to fix build issue
# if [ -f "$AR_COMPS/esp32-camera/idf_component.yml" ]; then
# 	rm -rf "$AR_COMPS/esp32-camera/idf_component.yml"
# fi
git -C "$AR_COMPS/esp32-camera" checkout "$(grep -e ^esp32-camera: $AR_COMPS/arduino/tools/sdk/versions.txt | cut -d ' ' -f 3)"
if [ $? -ne 0 ]; then exit 1; fi

#
# CLONE/UPDATE ESP-DL
#
echo "Updating ESP-DL..."
if [ ! -d "$AR_COMPS/esp-dl" ]; then
	git clone $DL_REPO_URL "$AR_COMPS/esp-dl"
else
	git -C "$AR_COMPS/esp-dl" fetch
fi
git -C "$AR_COMPS/esp-dl" checkout "$(grep -e ^esp-dl: $AR_COMPS/arduino/tools/sdk/versions.txt | cut -d ' ' -f 3)"
if [ $? -ne 0 ]; then exit 1; fi

#
# CLONE/UPDATE ESP-SR
#
echo "Updating ESP-SR..."
if [ ! -d "$AR_COMPS/esp-sr" ]; then
	git clone $SR_REPO_URL "$AR_COMPS/esp-sr"
else
	git -C "$AR_COMPS/esp-sr" fetch
fi
git -C "$AR_COMPS/esp-dl" checkout "$(grep -e ^esp-dl: $AR_COMPS/arduino/tools/sdk/versions.txt | cut -d ' ' -f 3)"
if [ $? -ne 0 ]; then exit 1; fi
#this is a temp measure to fix build issue
if [ -f "$AR_COMPS/esp-sr/idf_component.yml" ]; then
	rm -rf "$AR_COMPS/esp-sr/idf_component.yml"
fi
if [ $? -ne 0 ]; then exit 1; fi

#
# CLONE/UPDATE ESP-LITTLEFS
#
echo "Updating ESP-LITTLEFS..."
if [ ! -d "$AR_COMPS/esp_littlefs" ]; then
	git clone $LITTLEFS_REPO_URL "$AR_COMPS/esp_littlefs"
else
	git -C "$AR_COMPS/esp_littlefs" fetch
fi
if [ $? -ne 0 ]; then exit 1; fi
git -C "$AR_COMPS/esp_littlefs" checkout "$(grep -e ^esp_littlefs: $AR_COMPS/arduino/tools/sdk/versions.txt | cut -d ' ' -f 3)" && \
git -C "$AR_COMPS/esp_littlefs" submodule update --init --recursive
if [ $? -ne 0 ]; then exit 1; fi

#
# CLONE/UPDATE ESP-RAINMAKER
#
echo "Updating ESP-RainMaker..."
if [ ! -d "$AR_COMPS/esp-rainmaker" ]; then
    git clone $RMAKER_REPO_URL "$AR_COMPS/esp-rainmaker"
else
	git -C "$AR_COMPS/esp-rainmaker" fetch
fi
if [ $? -ne 0 ]; then exit 1; fi
git -C "$AR_COMPS/esp-rainmaker" checkout "$(grep -e ^esp-rainmaker: $AR_COMPS/arduino/tools/sdk/versions.txt | cut -d ' ' -f 3)" && \
git -C "$AR_COMPS/esp-rainmaker" submodule update --init --recursive
if [ $? -ne 0 ]; then exit 1; fi

#
# CLONE/UPDATE ESP-INSIGHTS
#
echo "Updating ESP-Insights..."
if [ ! -d "$AR_COMPS/esp-insights" ]; then
    git clone $INSIGHTS_REPO_URL "$AR_COMPS/esp-insights"
else
	git -C "$AR_COMPS/esp-insights" fetch
fi
if [ $? -ne 0 ]; then exit 1; fi
git -C "$AR_COMPS/esp-insights" checkout "$(grep -e ^esp-insights: $AR_COMPS/arduino/tools/sdk/versions.txt | cut -d ' ' -f 3)" && \
git -C "$AR_COMPS/esp-insights" submodule update --init --recursive
if [ $? -ne 0 ]; then exit 1; fi

#
# CLONE/UPDATE ESP-DSP
#
echo "Updating ESP-DSP..."
if [ ! -d "$AR_COMPS/esp-dsp" ]; then
	git clone $DSP_REPO_URL "$AR_COMPS/esp-dsp"
else
	git -C "$AR_COMPS/esp-dsp" fetch
fi
if [ $? -ne 0 ]; then exit 1; fi
git -C "$AR_COMPS/esp-dsp" checkout "$(grep -e ^esp-dsp: $AR_COMPS/arduino/tools/sdk/versions.txt | cut -d ' ' -f 3)"
if [ $? -ne 0 ]; then exit 1; fi

#
# CLONE/UPDATE TINYUSB
#
echo "Updating TinyUSB..."
if [ ! -d "$AR_COMPS/arduino_tinyusb/tinyusb" ]; then
	git clone $TINYUSB_REPO_URL "$AR_COMPS/arduino_tinyusb/tinyusb"
else
	git -C "$AR_COMPS/arduino_tinyusb/tinyusb" fetch
fi
if [ $? -ne 0 ]; then exit 1; fi
git -C "$AR_COMPS/arduino_tinyusb/tinyusb" checkout "$(grep -e ^tinyusb: $AR_COMPS/arduino/tools/sdk/versions.txt | cut -d ' ' -f 3)"
if [ $? -ne 0 ]; then exit 1; fi
