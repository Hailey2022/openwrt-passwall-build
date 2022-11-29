https://github.com/xiaorouji/openwrt-passwall && cd openwrt-passwall
wget https://downloads.openwrt.org/releases/22.03.2/targets/x86/64/openwrt-sdk-22.03.2-x86-64_gcc-11.2.0_musl.Linux-x86_64.tar.xz -O SDK.tar.xz
tar -Jxf SDK.tar.xz
cd openwrt-sdk-*
echo "src-git PWpackages https://github.com/xiaorouji/openwrt-passwall.git;packages" >> feeds.conf.default
echo "src-git PWluci https://github.com/xiaorouji/openwrt-passwall.git;luci" >> feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install luci-app-passwall
make defconfig
# make menuconfig

make download -j8 V=s && find dl -size -1024c -exec ls -l {} \; && make package/luci-app-passwall/{clean,compile} -j4
make package/index
