#!/bin/bash

# Upgrade System
sudo apt update && sudo apt upgrade -y
echo "========================================================================"
echo "                        SYSTEM UPGRADED"
echo "========================================================================="
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
echo "=============================================="
echo "       Cloning Mniafest..........."
echo "=============================================="
repo init --depth=1 --no-repo-verify -u https://github.com/yehonatan2020/losp_manifest -b lineage-22.1 --git-lfs
echo "=============================================="
echo "       Mniafest Cloned successfully"
echo "=============================================="

# Local manifests
echo "=================================="
echo "Cloning Local manifest............"
echo "=================================="
git clone https://github.com/tillua467/local_manifests --depth=1 -b LOSP .repo/local_manifests
echo "=================================="
echo "Local manifest cloned successfully"
echo "=================================="

# Sync
/opt/crave/resync.sh && repo --no-pager --color=always sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune
echo "============="
echo " Sync success"
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
echo "======Lunching....========"
lunch lineage_phoenix-ap3a-userdebug
echo "=====Lunching done========"

# Make cleaninstall
make installclean
echo "============="

# Build rom
echo "===================================="
echo "      Building LOSP..."
echo "===================================="
mka bacon
