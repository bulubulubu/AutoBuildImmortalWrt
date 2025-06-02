#!/bin/bash
# Log file for debugging
LOGFILE="/tmp/uci-defaults-log.txt"
echo "Starting 99-custom.sh at $(date)" >> $LOGFILE
# yml 传入的路由器型号 PROFILE
echo "Building for profile: $PROFILE"
# yml 传入的固件大小 ROOTFS_PARTSIZE
echo "Building for ROOTFS_PARTSIZE: $ROOTFS_PARTSIZE"

echo "Create pppoe-settings"
mkdir -p  /home/build/immortalwrt/files/etc/config

# 创建pppoe配置文件 yml传入环境变量ENABLE_PPPOE等 写入配置文件 供99-custom.sh读取
cat << EOF > /home/build/immortalwrt/files/etc/config/pppoe-settings
enable_pppoe=${ENABLE_PPPOE}
pppoe_account=${PPPOE_ACCOUNT}
pppoe_password=${PPPOE_PASSWORD}
EOF

echo "cat pppoe-settings"
cat /home/build/immortalwrt/files/etc/config/pppoe-settings

# 输出调试信息
echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting build process..."


# 定义所需安装的包列表 下列插件你都可以自行删减
PACKAGES=""
PACKAGES="$PACKAGES curl"
PACKAGES="$PACKAGES luci-i18n-diskman-zh-cn"
PACKAGES="$PACKAGES luci-i18n-package-manager-zh-cn"
PACKAGES="$PACKAGES luci-i18n-firewall-zh-cn"
# 服务——FileBrowser 用户名admin 密码admin
PACKAGES="$PACKAGES luci-i18n-filebrowser-go-zh-cn"
PACKAGES="$PACKAGES luci-app-argon-config"
PACKAGES="$PACKAGES luci-i18n-argon-config-zh-cn"
PACKAGES="$PACKAGES luci-i18n-ttyd-zh-cn"
PACKAGES="$PACKAGES luci-i18n-passwall-zh-cn"
PACKAGES="$PACKAGES luci-app-openclash"
PACKAGES="$PACKAGES luci-i18n-homeproxy-zh-cn"
PACKAGES="$PACKAGES openssh-sftp-server"
PACKAGES="$PACKAGES luci-i18n-dockerman-zh-cn"
# 增加几个必备组件 方便用户安装iStore
PACKAGES="$PACKAGES fdisk"
PACKAGES="$PACKAGES script-utils"
PACKAGES="$PACKAGES luci-i18n-samba4-zh-cn"

PACKAGES="$PACKAGES luci-app-adguardhome"
PACKAGES="$PACKAGES luci-app-argon-config"
PACKAGES="$PACKAGES luci-app-aria2"
PACKAGES="$PACKAGES luci-app-arpbind"
PACKAGES="$PACKAGES luci-app-cifs-mount"
PACKAGES="$PACKAGES luci-app-commands"
PACKAGES="$PACKAGES luci-app-cpulimit"
PACKAGES="$PACKAGES luci-app-ddns"
PACKAGES="$PACKAGES luci-app-diskman"
PACKAGES="$PACKAGES luci-app-diskman_INCLUDE_btrfs_progs"
PACKAGES="$PACKAGES luci-app-diskman_INCLUDE_lsblk"
PACKAGES="$PACKAGES luci-app-diskman_INCLUDE_mdadm"
PACKAGES="$PACKAGES luci-app-diskman_INCLUDE_kmod_md_raid456"
PACKAGES="$PACKAGES luci-app-diskman_INCLUDE_kmod_md_linear"
PACKAGES="$PACKAGES luci-app-eqos"
PACKAGES="$PACKAGES luci-app-filetransfer"
PACKAGES="$PACKAGES luci-app-fileassistant"
PACKAGES="$PACKAGES luci-app-frpc"
PACKAGES="$PACKAGES luci-app-gowebdav"
PACKAGES="$PACKAGES luci-app-guest-wifi"
PACKAGES="$PACKAGES luci-app-hd-idle"
PACKAGES="$PACKAGES luci-app-ipsec-server"
PACKAGES="$PACKAGES luci-app-n2n_v2"
PACKAGES="$PACKAGES luci-app-netdata"
PACKAGES="$PACKAGES luci-app-nfs"
PACKAGES="$PACKAGES luci-app-nps"
PACKAGES="$PACKAGES luci-app-openclash"
PACKAGES="$PACKAGES luci-app-openvpn-server"
PACKAGES="$PACKAGES luci-app-passwall"
PACKAGES="$PACKAGES luci-app-passwall_INCLUDE_Brook"
PACKAGES="$PACKAGES luci-app-passwall_INCLUDE_ChinaDNS_NG"
PACKAGES="$PACKAGES luci-app-passwall_INCLUDE_Haproxy"
PACKAGES="$PACKAGES luci-app-passwall_INCLUDE_Hysteria"
PACKAGES="$PACKAGES luci-app-passwall_INCLUDE_Kcptun"
PACKAGES="$PACKAGES luci-app-passwall_INCLUDE_PDNSD"
PACKAGES="$PACKAGES luci-app-passwall_INCLUDE_Simple_Obfs"
PACKAGES="$PACKAGES luci-app-passwall_INCLUDE_Trojan_GO"
PACKAGES="$PACKAGES luci-app-passwall_INCLUDE_Trojan_Plus"
PACKAGES="$PACKAGES luci-app-passwall_INCLUDE_V2ray"
PACKAGES="$PACKAGES luci-app-passwall_INCLUDE_V2ray_Plugin"
PACKAGES="$PACKAGES luci-app-passwall_INCLUDE_Xray"
PACKAGES="$PACKAGES luci-app-pptp-server"
PACKAGES="$PACKAGES luci-app-pushbot"
PACKAGES="$PACKAGES luci-app-samba"
PACKAGES="$PACKAGES luci-app-serverchan"
PACKAGES="$PACKAGES luci-app-smartdns"
PACKAGES="$PACKAGES luci-app-softethervpn"
PACKAGES="$PACKAGES luci-app-sqm"
PACKAGES="$PACKAGES luci-app-ssr-plus"
PACKAGES="$PACKAGES luci-app-ssr-plus_INCLUDE_Kcptun"
PACKAGES="$PACKAGES luci-app-ssr-plus_INCLUDE_Redsocks2"
PACKAGES="$PACKAGES luci-app-ssr-plus_INCLUDE_Simple_Obfs"
PACKAGES="$PACKAGES luci-app-ssr-plus_INCLUDE_Trojan"
PACKAGES="$PACKAGES luci-app-ssr-plus_INCLUDE_V2ray_Plugin"
PACKAGES="$PACKAGES luci-app-ssr-plus_INCLUDE_Xray"
PACKAGES="$PACKAGES luci-app-transmission"
PACKAGES="$PACKAGES luci-app-turboacc"
PACKAGES="$PACKAGES TURBOACC_INCLUDE_BBR_CCA"
PACKAGES="$PACKAGES TURBOACC_INCLUDE_DNSFORWARDER"
PACKAGES="$PACKAGES TURBOACC_INCLUDE_DNSPROXY"
PACKAGES="$PACKAGES TURBOACC_INCLUDE_OFFLOADING"
PACKAGES="$PACKAGES luci-app-ttyd"
PACKAGES="$PACKAGES luci-app-usb-printer"
PACKAGES="$PACKAGES luci-app-watchcat"
PACKAGES="$PACKAGES luci-app-webadmin"
PACKAGES="$PACKAGES luci-app-wifischedule"
PACKAGES="$PACKAGES luci-app-wireguard"
PACKAGES="$PACKAGES luci-app-wrtbwmon"
PACKAGES="$PACKAGES luci-app-zerotier"
PACKAGES="$PACKAGES luci-proto-modemmanager"
PACKAGES="$PACKAGES luci-proto-bonding"
PACKAGES="$PACKAGES luci-proto-openconnect"
PACKAGES="$PACKAGES luci-proto-relay"
PACKAGES="$PACKAGES luci-theme-argonv3"
PACKAGES="$PACKAGES luci-theme-material"

# 构建镜像
echo "$(date '+%Y-%m-%d %H:%M:%S') - Building image with the following packages:"
echo "$PACKAGES"

make image PROFILE=$PROFILE PACKAGES="$PACKAGES" FILES="/home/build/immortalwrt/files" ROOTFS_PARTSIZE=$ROOTFS_PARTSIZE

if [ $? -ne 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: Build failed!"
    exit 1
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') - Build completed successfully."
