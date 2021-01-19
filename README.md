# dotfiles

For Arch Linux.

---
title: "Arch Linux Installation Guide"
date: 2020-09-25T20:05:25+08:00
draft: false
---

> 更新于2021.1

## 一、基本系统安装

### 前置准备

关闭BIOS安全启动 & 关闭Windows快速启动

### 设置tty字体

`setfont ter-132n`

### 首次连接网络

`iwctl`

`device list`

`station wlan0 scan`

`station wlan0 get-networks`

`station wlan0 connect SSID`

`quit`

### 设置系统时间

`timedatectl set-ntp true`

### 格式化并挂载分区

`lsblk`

格式化根分区：

`mkfs.btrfs -f -L Arch /dev/sdaX`

挂载根分区：

`mount /dev/sdaX /mnt`

格式化ESP分区：

`mkfs.vfat /dev/sdaY`

挂载ESP分区：

`mkdir /mnt/boot`

`mount /dev/sdaY /mnt/boot`

### 安装系统基础软件包

`pacstrap /mnt base base-devel linux linux-firmware btrfs-progs dosfstools intel-ucode efibootmgr fish iwd neovim`

### 生成fstab

`genfstab -U /mnt >> /mnt/etc/fstab`

`cat /mnt/etc/fstab`

### 进入新系统

`arch-chroot /mnt`

### 时区

`ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime`

`hwclock --systohc`

### 本地化

`nvim /etc/locale.gen`

```
en_US.UTF-8 UTF-8
ja_JP.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
```

`locale-gen`

`echo LANG=en_US.UTF-8 > /etc/locale.conf`

### 主机名

`echo matebook > /etc/hostname`

### hosts

`nvim /etc/hosts`

```
127.0.0.1	localhost
::1		localhost
127.0.0.1	matebook.localdomain	matebook
```

### 配置initramfs参数

`nvim /etc/mkinitcpio.conf`

```
HOOKS=(添加 btrfs)
```

`mkinitcpio -P`

### 设置root密码

`passwd`

### 安装引导程序

可在nvim中执行`:r !blkid -s PARTUUID -o value /dev/sdaX`以获取根分区PARTUUID

`bootctl --path=/boot install`

`nvim /boot/loader/loader.conf`

```
timeout  3
default  arch
```

`nvim /boot/loader/entries/arch.conf `

```
title    Arch Linux
linux    /vmlinuz-linux
initrd   /intel-ucode.img
initrd   /initramfs-linux.img
options  root=PARTUUID=d22644f6-8d53-44d6-80cf-4990db6e532c rw rootflags=subvol=/
```

### 重启

`exit`

`reboot`

### 重新连接网络

`systemctl enable --now systemd-networkd.service`

`systemctl enable --now systemd-resolved.service`

`systemctl enable --now iwd.service`

`nvim /etc/iwd/main.conf`

```
[General]
EnableNetworkConfiguration=true
[Network]
NameResolvingService=systemd
```

`systemctl restart iwd.service`

`iwctl`

### 添加新用户

`useradd -mG wheel,video,input huizhi`

`passwd huizhi`

`nvim /etc/sudoers`

```
去掉# %wheel ALL=(ALL)ALL 之前的注释符#
```

## 二、图形界面安装

### 显示

`pacman -S mesa vulkan-intel intel-media-driver light`

### 声音

`pacman -S alsa-utils pulseaudio pulseaudio-alsa`

### 触控板

`pacman -S xf86-input-libinput`

`ruby-fusuma`（AUR）

### X

`pacman -S xorg-server xorg-xinit xorg-xsetroot`

### 窗口管理器

`pacman -S bspwm sxhkd`

### 终端

`pacman -S alacritty`

### 启动器

`pacman -S rofi`

### 切换用户

`su huizhi`

`cd`

### HiDPI

`nvim ~/.Xresources`

```
Xft.dpi: 120
```

### xinitrc

`nvim ~/.xinitrc`

```
xrdb -merge ~/.Xresources
export LANG=zh_CN.UTF-8
exec bspwm
```

### 基础配置文件

`mkdir -p .config/bspwm`

`cp /usr/share/doc/bspwm/examples/bspwmrc .config/bspwm`

`mkdir .config/sxhkd`

`cp /usr/share/doc/bspwm/examples/sxhkdrc .config/sxhkd`

`nvim .config/sxhkd/sxhkdrc`

```
uxrvt ==> alacritty -e fish
dmenu ==> rofi -show drun
```

### 字体

`sudo pacman -S ttf-sarasa-gothic adobe-source-han-serif-otc-fonts noto-fonts-emoji`

### 重启

`sudo reboot`

使用普通用户登陆

### 启动图形界面

`startx`

## 三、软件清单

#### 浏览器

`sudo pacman -S firefox firefox-i18n-zh-cn`

### 源

修改镜像列表：

`sudo vim /etc/pacman.d/mirrorlist`

```
Server = https://mirrors.xjtu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.bfsu.edu.cn/archlinux/$repo/os/$arch
```

Archlinuxcn源：

`sudo vim /etc/pacman.conf`

```
[archlinuxcn]
Server = https://mirrors.xjtu.edu.cn/archlinuxcn/$arch
```

`sudo pacman -Syy && sudo pacman -S archlinuxcn-keyring`

AUR：

`sudo pacman -S yay`

#### 代理

`clash proxychains-ng`

#### 通讯

`telegram-desktop`

#### 在线音乐

`musicfox`（AUR）

#### 在线会议

`zoom`（AUR）

#### 下载工具

`youtube-dl vdhcoapp`

`xunlei-bin`（AUR）

#### 网盘

`nutstore`

#### 局域网ftp文件共享

`vsftpd`

#### 局域网http媒体中心

`nginx`

#### 壁纸

`hsetroot`

#### 面板

`polybar`

#### 合成器

`picom`

#### 屏幕色温调节

`redshift`

#### 锁屏

`xsecurelock`

#### 通知

`dunst`

#### 输入法

`ibus ibus-rime ibus-mozc`

#### 文件管理

`nautilus ffmpegthumbnailer udiskie gvfs-mtp fuse2 file-roller p7zip unrar rsync tree`

#### 图片浏览器

`viewnior`

#### 音乐播放器

`cmus`

#### 视频播放器

`mpv`

#### 截图

`imagemagick`

#### 录屏

`obs-studio`

#### 图像编辑

`gimp`

#### 视频剪辑

`olive-git`（AUR）

#### 剪贴板管理器

`xclip`

`rofi-greenclip`（AUR）

#### 办公

`wps-office-cn wps-office-mui-zh-cn`（AUR）

`ttf-wps-fonts`

#### 流程图

`drawio-desktop-bin`

#### 笔记

`typora`

#### 博客

`hugo`

#### 开发

`git code`

`nodejs-nativefier`（AUR）

#### Android

`android-tools scrcpy`

#### 虚拟机

`virtualbox`

如内核为`linux` ，内核模块应安装`virtualbox-host-modules-arch`

#### 系统信息

`neofetch`

#### 自动化

`cronie`

#### 主题美化

`materia-gtk-theme qogir-icon-theme-git lxappearance-gtk3`

#### 文档

`man-db man-pages`

#### 设置默认程序

`selectdefaultapplication-git`（AUR）

---
title: "Arch Linux Configuration Guide"
date: 2020-10-25T20:48:55+08:00
draft: false
---

> 更新于2021.1

## 硬件

### 触控板优化

`sudo nvim /usr/share/X11/xorg.conf.d/40-libinput.conf`

```
Option "Tapping" "on"
Option "NaturalScrolling" "true"
```

`reboot`

### 自动挂载资料分区并修改所有者及权限

`sudo mkdir /data`

`sudo nvim /etc/fstab`

```
/dev/sdb1	/data	ext4	defaults	0	0
```

`sudo mount -a`

`cd /data`

设置所有文件权限为644：

`sudo find ./ -type f -exec chmod 644 {} \;`

设置所有目录权限为755：

`sudo find ./ -type d -exec chmod 755 {} \;`

### Nvidia显卡

方案一：

禁用Nvidia显卡

安装bbswitch：

`sudo pacman -S bbswitch`

开机加载bbswitch模块：

`sudo nvim /etc/modules-load.d/bbswitch.conf`

键入：

`bbswitch`

设置bbswitch加载参数，实现开机时关闭独显，关机时开启独显，避免重启进入Windows时找不到独显：

`sudo nvim /etc/modprobe.d/bbswitch.conf`

键入：

`options bbswitch load_state=0 unload_state=1`

屏蔽nouveau驱动:

`sudo nvim /etc/modprobe.d/blacklistnvidia.conf`

键入：

`blacklist nouveau`

重建 initrd：

`sudo mkinitcpio -P`

重启：

`reboot`

执行：

`lspci | grep NVIDIA`

如有 (rev ff)字样 ，则表示独显已成功禁用。

方案二：

prime方案

`yay -S nvidia nvidia-prime`

### 加快关机速度

`sudo nvim /etc/systemd/system.conf`

```
DefaultTimeoutStopSec=3s
```

## 软件

### 建立常用目录（的软链接）

`cd ~ && mkdir Desktop Documents Downloads && ln -s /data/Videos Videos && ln -s /data/Music Music && ln -s /data/Pictures Pictures && ln -s /data/Hugo Hugo`

### git

`git config --global user.name "qvshuo" && git config --global user.email qvshuo@foxmail.com`

`ssh-keygen -t rsa -C qvshuo@foxmail.com`

`cat ~/.ssh/id_rsa.pub`

`ssh -T git@github.com`

### 恢复配置文件

`git clone git@github.com:qvshuo/dotfiles.git`

`./rsync`

### fish

取消欢迎语：

`set -U fish_greeting`

样式设置：

`fish_config`

### Firefox

`about:config`

```
退格键返回：（将值由2改成0）
browser.backspace_action

双击关闭标签页：
browser.tabs.closeTabByDblclick

Hardware video acceleration:

true:
media.ffmpeg.vaapi.enabled

false:
media.ffvpx.enabled
```

终结内容农场

`https://raw.githubusercontent.com/danny0838/content-farm-terminator/gh-pages/files/blocklist/content-farms.txt`

### proxychains

`sudo nvim /etc/proxychains.conf`

```
quiet_mode
# proxy_dns
http    127.0.0.1   7890
```

### vsftpd

`sudo nvim /etc/vsftpd.conf`

```
local_enable=YES
write_enable=YES
```

`sudo systemctl enable --now vsftpd.service`

### nginx

`sudo nvim /etc/nginx/nginx.conf`

```
worker_processes  1;

events {
    worker_connections  1024;
}

http {
    include  mime.types;
    default_type  octet-stream;

    server {
        listen  8765;

        location / {
            root   /data/Videos;
            autoindex on;
            autoindex_exact_size off;
            autoindex_localtime on;
            charset utf-8;
	    add_before_body /autoindex/before.html;
	    add_after_body /autoindex/after.html;
        }

    }

}
```

`sudo systemctl enable --now nginx.service`

### hsetroot

`cd ~/Desktop`

`proxychains git clone git@github.com:qvshuo/dynamic_wallpaper.git`

### polybar

脚本

`cd ~/Desktop`

`proxychains git clone git@github.com:qvshuo/polybar-scripts.git`

`yay -S jq`

### ibus

`ibus-setup`

Rime同步

`nvim ~/.config/ibus/rime/installation.yaml`

```
installation_id: "archlinux"
sync_dir: /data/我的坚果云/rimesync
```

### nodejs-nativefier

`cd ~/Desktop`

`proxychains git clone git@github.com:qvshuo/wechat_css.git`

### scrcpy

有线:

`sudo adb devices`

无线:

`sudo adb tcpip 5556 && adb connect 192.168.3.120:5556`

### cron

`sudo systemctl enable --now cronie.service`

`crontab -e`

```
0 * * * * export DISPLAY=:0 && /home/huizhi/Desktop/dynamic_wallpaper/your_name/your_name.sh &
15 7 * * * export DISPLAY=:0 && alacritty -e mpv --loop ~/Videos/alarm.mp4 &
```

### 获取程序名称

`xprop | grep WM_CLASS`

### 获取中文字体列表

`fc-list :lang=zh`

```
Sarasa Gothic SC

Source Han Serif SC

Sarasa Mono SC
```

### 从Windows安装字体

`sudo mkdir /usr/share/fonts/WindowsFonts && sudo cp /media/Windows/Windows/Fonts/* /usr/share/fonts/WindowsFonts && sudo chmod 755 /usr/share/fonts/WindowsFonts/* && fc-cache -f`
