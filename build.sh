#!/bin/bash

echo "================================================"
echo "  Files Are already Cloned Starting the build"
echo "================================================"

# Export
echo "======= Exporting ======"
export BUILD_USERNAME=tillua467 
export BUILD_HOSTNAME=crave
export TARGET_DISABLE_EPPE=true
export BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
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
echo "   STARTING Build EVOLUTION-X"
echo "===================================="
m evolution
