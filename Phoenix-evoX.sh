#!/bin/bash

# Upgrade System

sudo apt update && sudo apt upgrade -y

echo "========================================================================"
echo "                        SYSTEM UPGRADED"
echo "========================================================================="

sudo apt install ccache

echo "========================================================================"
echo "                   INSTALLED NECESSARY STUFF'S "
echo "========================================================================="


# Remove Unnecessary Files
echo "===================================="
echo "     Removing Unnecessary Files"
echo "===================================="
rm -rf .repo/local_manifests
rm -rf  vendor/xiaomi
rm -rf  kernel/xiaomi
rm -rf  device/xiaomi
rm -rf device/xiaomi/sm6150-common
rm -rf vendor/xiaomi/sm6150-common
rm -rf hardware/xiaomi

echo "===================================="
echo "  Removing Unnecessary Files Done"
echo "===================================="




# repo init rom
repo init -u https://github.com/Evolution-X/manifest -b vic --git-lfs
echo "=============================================="
echo "       Cloned Mniafest successfully"
echo "=============================================="

# Local manifests
git clone https://github.com/tillua467/local_manifests -b main .repo/local_manifests
echo "============================"
echo "Local manifest cloned successfully"
echo "============================"

# Sync
/opt/crave/resync.sh && repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
echo "============="
echo "Sync success"
echo "============="

# Export
echo "======= Exporting........ ======"
export BUILD_USERNAME=tillua467 
export BUILD_HOSTNAME=crave
export TARGET_DISABLE_EPPE=true
export TZ=Asia/Dhaka
echo "======= Export Done ======"

# Set up build environment
echo "====== Starting Envsetup ======="
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
lunch lineage_phoenix-ap3a-userdebug 
echo "=====Lunching done========"

# Make cleaninstall
make installclean
echo "============="

# Build rom
echo "===================================="
echo "      Building EVOLUTION-X..."
echo "===================================="
m evolution
