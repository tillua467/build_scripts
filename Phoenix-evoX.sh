#!/bin/bash

# Upgrade System

sudo apt update && sudo apt upgrade -y
echo "========================================================================"
echo "                        SYSTEM UPGRADED"
echo "========================================================================="
sudo apt install -y ccache
git clone https://github.com/akhilnarang/scripts
cd scripts || exit
sudo bash setup/android_build_env.sh
cd ..
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
rm -rf out/target/product/*/*zip
rm -rf out/target/product/*/*txt
rm -rf out/target/product/*/boot.img
rm -rf out/target/product/*/recovery.img
rm -rf out/target/product/*/super*img

echo "===================================="
echo "  Removing Unnecessary Files Done"
echo "===================================="




# repo init rom
repo init -u https://github.com/Evolution-X/manifest --depth=1 -b vic --git-lfs
echo "=============================================="
echo "       Cloned Mniafest successfully"
echo "=============================================="

# Local manifests
git clone https://github.com/tillua467/local_manifests --depth=1 -b main .repo/local_manifests
echo "=================================="
echo "Local manifest cloned successfully"
echo "=================================="

# Cloning system repos
rm -rf system/Core
echo "======= Cloning Some System Repos ========"
git clone https://github.com/LineageOS/android_system_core -b lineage-22.0 system/core
echo "======== Cloned Some System Repos ========"
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
export ALLOW_MISSING_DEPENDENCIES=true
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
