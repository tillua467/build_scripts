#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/Evolution-X/manifest -b vic --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/tillua467/local_manifests -b main .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=tillua467 
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
lunch lineage_phoenix-ap3a-userdebug 
echo "=====Lunching done========"

# Make cleaninstall
make installclean
echo "============="

# Build rom
m evolution
