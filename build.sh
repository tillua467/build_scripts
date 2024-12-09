#!/bin/bash
# crave run --clean --no-patch -- "curl https://raw.githubusercontent.com/tillua467/build_scripts/refs/heads/main/build.sh | bash"
echo "================================================"
echo "  Files Are already Cloned. Starting the build"
echo "================================================"

# Export
echo "======= Exporting ======"
export BUILD_USERNAME=tillua467 
export BUILD_HOSTNAME=crave
export TARGET_DISABLE_EPPE=true
echo "======= Export Done ======"

# Set up build environment
echo "====== Starting  Envsetup  ======="
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
echo "=====Lunching========"
lunch lineage_phoenix-ap3a-userdebug 
echo "=====Lunching done========"


# Build rom
echo "===================================="
echo "   STARTING TO BUILD EVOLUTION-X"
echo "===================================="
m evolution
