#### Install ArchLinux

timedatectl set-ntp ture

1. cfdisk 分区

* /dev/sda1    primary  bootable type:linux

* /dev/sda2    primary type: Linux Swap / Solaris

```shell
mkfs.ext4 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
```

2. 挂载

```
mount /dev/sda1 /mnt
```

3. 更新/etc/pacman.d/mirrorlist

```
wget -q -O - 'https://u.nu/archcn4' > /etc/pacman.d/mirrorlist
sed -i 's/^#Server/Server/g' /etc/pacman.d/mirrorlist
```

4. 安装

```
pacstrap /mnt base base-devel linux linux-firmware
```

5. 生成分区表

```
genfstab -U /mnt >> /mnt/etc/fstab
// 检查是否正常
cat /mnt/etc/fstab
```

6. change root

```
arch-chroot /mnt
```

7. 时区设置

```
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc --utc
```

8. Locale

```
sed -i '1ien_US.UTF-8 UTF-8' /etc/locale.gen
sed -i '2izh_CN.UTF-8 UTF-8' /etc/locale.gen
sed -i '3izh_TW.UTF-8 UTF-8' /etc/locale.gen
locale-gen

echo 'LANG=en_US.UTF-8' > /etc/locale.conf
```

9. 主机名

```
echo 'Arch' > /etc/hostname

/etc/hosts
127.0.0.1			localhost
::1						localhost
```

10. NetworkManager

```
pacman -S networkmanager
systemctl enable NetworkManager
```

11. BootLoader

```
pacman -S grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
```

12. Passwd root

```
passwd

exit
reboot
```

13. /etc/pacman.conf

```
[multilib]
include = /etc/pacman.d/mirrorlist

pacman -S bash-completion
```

14. useradd

```
useradd -m -g users -G audio,video,network,wheel,storage,rfkill -s /bin/bash wg
pacman -S sudo
passwd wg
visudo
%wheel ALL=(ALL) ALL
```

#### Window Manager

```
pacman -S sddm
pacman -S xorg-server xorg-apps
systemctl enable sddm.service
pacman -S xmonad xmonad-contrib
pacman -S gtk2 gtk3
pacman -S faenza-icon-theme
pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji
pacman -S feh
pacman -S neovim git

git clone https://aur.archlinux.org/aurman.git
cd aurman
makepkg -si
gpg --recv-keys key
aurman -S zuki-themes
aurman -S polybar

```

#### fdisk

```
fdisk /dev/sda

d  delete partition
n  new partition

boot partition

partition type: default primary
partition number: default 1
first sector: default
last sector: +200M
do you want to remove signature ? Yes

swap partition

partition type: default primary
partition number: default 2
first sector: default
last sector: +15G      15% ? 50%?

root partition

partition type: default primary
partition number: default 3
first sector: default
last sector: +25G
do you want to remove signature ? Yes

home partition

partition type: p primary
partition number: default 4
first sector: default
last sector: default (whole remain)
do you want to remove signature ? Yes

w write

a toggle boot partition

mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4
mkswap /dev/sda2
swapon /dev/sda2


mount /dev/sda3 /mnt

mkdir /mnt/home
mkdir /mnt/boot

mount /dev/sda1 /mnt/boot
mount /dev/sda4 /mnt/home

umount -R /mnt

```

