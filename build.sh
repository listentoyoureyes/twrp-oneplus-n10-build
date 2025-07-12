#!/bin/bash
# TWRP Build Script for OnePlus Nord N10 5G (billie)

set -e

echo "🚀 Starting TWRP build for OnePlus Nord N10 5G..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running in proper environment
if [ ! -f /etc/lsb-release ]; then
    echo -e "${RED}❌ This script requires Ubuntu/Debian environment${NC}"
    exit 1
fi

# Install dependencies
echo -e "${YELLOW}📦 Installing build dependencies...${NC}"
sudo apt update
sudo apt install -y git-core gnupg flex bison build-essential zip curl \
    zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev \
    x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils \
    xsltproc unzip fontconfig python3 python3-pip openjdk-8-jdk

# Install repo tool
echo -e "${YELLOW}🔧 Installing repo tool...${NC}"
mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
export PATH=~/bin:$PATH

# Set up build directory
echo -e "${YELLOW}📁 Setting up build directory...${NC}"
mkdir -p ~/twrp-build
cd ~/twrp-build

# Initialize repo
echo -e "${YELLOW}🔄 Initializing TWRP source...${NC}"
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-11

# Sync source
echo -e "${YELLOW}📥 Syncing source code (this may take a while)...${NC}"
repo sync -j$(nproc)

# Add device tree
echo -e "${YELLOW}📱 Adding OnePlus Nord N10 5G device tree...${NC}"
git clone https://github.com/EduardoA3677/device_oneplus_billie_twrp.git device/oneplus/billie

# Build TWRP
echo -e "${YELLOW}🏗️ Building TWRP...${NC}"
export ALLOW_MISSING_DEPENDENCIES=true
source build/envsetup.sh
lunch twrp_billie-eng
mka recoveryimage

echo -e "${GREEN}✅ TWRP build completed!${NC}"
echo -e "${GREEN}📱 Recovery image location: out/target/product/billie/recovery.img${NC}"
echo -e "${YELLOW}⚠️  Flash with: fastboot flash recovery recovery.img${NC}"
