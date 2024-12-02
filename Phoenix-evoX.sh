#!/bin/bash
# Remove Unnecessary Files
rm -rf .repo/local_manifests
rm -rf  vendor/xiaomi
rm -rf  kernel/xiaomi
rm -rf  device/xiaomi
rm -rf hardware/xiaomi

echo "===================================="
echo "Removing Unnecessary Files"
echo "===================================="



# repo init rom
repo init -u https://github.com/Evolution-X/manifest -b vic --git-lfs
echo "=================="
echo "Cloned Mniafest successfully"
echo "=================="

# Local manifests
git clone https://github.com/tillua467/local_manifests -b main .repo/local_manifests
echo "============================"
echo "Local manifest cloned successfully"
echo "============================"

# Sync
/opt/crave/resync.sh || repo sync
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=tillua467 
export BUILD_HOSTNAME=crave
export TARGET_DISABLE_EPPE=true
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
lunch lineage_phoenix-ap3a-userdebug 
echo "=====Lunching done========"

# Make cleaninstall
# make installclean
# echo "============="

# Build rom
echo "===================================="
echo "Building EVOLUTION-X..."
echo "===================================="
m evolution
