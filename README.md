# TWRP Build for OnePlus Nord N10 5G

This repository contains build scripts and configuration for building TWRP (Team Win Recovery Project) for the OnePlus Nord N10 5G (codename: billie).

## Device Information
- **Device**: OnePlus Nord N10 5G
- **Codename**: billie
- **Architecture**: ARM64
- **Android Version**: 10/11
- **Bootloader**: Unlocked required

## Build Requirements
- Ubuntu 20.04 LTS (recommended)
- 16GB+ RAM
- 200GB+ free disk space
- Git, repo tool, and Android build dependencies

## Build Instructions

### 1. Set up environment
```bash
# Install dependencies
sudo apt update
sudo apt install -y git-core gnupg flex bison build-essential zip curl \
    zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev \
    x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils \
    xsltproc unzip fontconfig python3 python3-pip openjdk-8-jdk

# Install repo tool
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
export PATH=~/bin:$PATH
```

### 2. Initialize TWRP source
```bash
mkdir -p ~/twrp-build
cd ~/twrp-build
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-11
repo sync -j$(nproc)
```

### 3. Add device tree
```bash
git clone https://github.com/EduardoA3677/device_oneplus_billie_twrp.git device/oneplus/billie
```

### 4. Build TWRP
```bash
export ALLOW_MISSING_DEPENDENCIES=true
source build/envsetup.sh
lunch twrp_billie-eng
mka recoveryimage
```

## Device Tree
- Source: https://github.com/EduardoA3677/device_oneplus_billie_twrp
- Dependencies: Qualcomm common files (included in minimal manifest)

## Warning
- This will void your warranty
- Ensure bootloader is unlocked
- Backup your device before flashing
- Use at your own risk

## Credits
- EduardoA3677 for the device tree
- TeamWin for TWRP
- OnePlus for the device
