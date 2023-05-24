# openwrt-22-8812

Openwrt with rtl8812au-ac drivers with support AP.

# rtl8812au-ac

Drivers rtl8812au-ac with `hostapd` 5ghz support from https://github.com/immortalwrt/immortalwrt

## Requirements

- RAM >= 8 Gb
- Docker (install docker-ce https://docs.docker.com/engine/install/)
- config docker to use from Not root user ( https://docs.docker.com/engine/security/rootless/ ) 
- !!!Attention!!! on Windows or MacOS change Docker VM daemon settings! RAM>=8Gb

## How to use

Use with openwrt v22.03.5

`git clone https://github.com/x0rium/8211ac.git rtl8812au-ac`

Copy this files in package/kernel/rtl8812au-ac/

`cp -r  rtl8812au-ac ./package/kernel/`

Run Docker image build 

`./owrtbuild init v22.03.5`

`make menuconfig`

- Target System (x86)
- Subtarget (x86_64)
- Target Profile (Generic x86/64)
- Kernel modules  ---> Wireless Drivers  ---> kmod-mac80211
- Kernel modules  ---> Wireless Drivers  ---> kmod-rtl8812au-ac

`make -j$(nproc) kernel_menuconfig`

`make -j$(nproc) defconfig download clean world V=sc` 

Answer on all questions "N" 

Coffeee ) 

Look at results `ls ./bin/targets/x86/64/`

```
drwxr-xr-x   4 x0rium  staff   128B 24 май 04:36 ..
-rw-r--r--   1 x0rium  staff   944B 24 май 04:23 config.buildinfo
-rw-r--r--   1 x0rium  staff   288B 24 май 04:23 feeds.buildinfo
-rw-r--r--   1 x0rium  staff    12M 24 май 04:31 openwrt-x86-64-generic-ext4-combined-efi.img.gz
-rw-r--r--   1 x0rium  staff    12M 24 май 04:31 openwrt-x86-64-generic-ext4-combined.img.gz
-rw-r--r--   1 x0rium  staff   6,8M 24 май 04:31 openwrt-x86-64-generic-ext4-rootfs.img.gz
-rw-r--r--   1 x0rium  staff   5,0M 24 май 04:31 openwrt-x86-64-generic-kernel.bin
-rw-r--r--   1 x0rium  staff   6,7M 24 май 04:31 openwrt-x86-64-generic-rootfs.tar.gz
-rw-r--r--   1 x0rium  staff    11M 24 май 04:31 openwrt-x86-64-generic-squashfs-combined-efi.img.gz
-rw-r--r--   1 x0rium  staff    11M 24 май 04:31 openwrt-x86-64-generic-squashfs-combined.img.gz
-rw-r--r--   1 x0rium  staff   5,4M 24 май 04:31 openwrt-x86-64-generic-squashfs-rootfs.img.gz
-rw-r--r--   1 x0rium  staff   4,0K 24 май 04:31 openwrt-x86-64-generic.manifest
drwxr-xr-x  85 x0rium  staff   2,7K 24 май 04:31 packages
-rw-r--r--   1 x0rium  staff   2,4K 24 май 04:32 profiles.json
-rw-r--r--   1 x0rium  staff   1,3K 24 май 04:32 sha256sums
-rw-r--r--   1 x0rium  staff    18B 24 май 04:23 version.buildinfo
```

to copy from container open new terminal tab and use `docker cp` command.
https://docs.docker.com/engine/reference/commandline/cp/

execute `exit` in console

in folder with `owrtbuild` you can find `target` directory with copy from our container.

Congrats!

## Troubles

If you are exit from container `./owrtbuild attach`
If want to clean all and to try one more time `./owrtbuild attach cleanup`
If you want clear docker enviroment use `docker system prune` this command clean unsed things %)

If make return error try use `-j1` and read this manual one more time or use `make clean` change config by command `make menuconfig`

Good luck!

Donations BTC: 3CL6LvEjTXhsa6TPt6qmtm4Rq7jrA7FYHD



