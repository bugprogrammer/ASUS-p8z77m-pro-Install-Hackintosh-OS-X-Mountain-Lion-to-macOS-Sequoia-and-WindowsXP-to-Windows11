# ASUS-p8z77m-pro-Install-Hackintosh-OS-X-Mountain-Lion-to-macOS-Tahoe-and-WindowsXP-to-Windows11
> macOS 26 是 Intel Mac 可以使用的最后一个 macOS 版本，在即将到来的 WWDC 2026 上，Apple 将发布 macOS 27，届时将仅支持 Apple Silicon Macs。在黑苹果即将成为历史的时刻，笔者在一台配备了 4K 显示器的 ivy bridge 计算机上以物理机的形式安装并运行了包括 Windows XP-Windows11 的所有 Windows 操作系统版本以及所有支持 4K 60hz hidpi 的 intel macOS 操作系统版本。

![](images/desktop/操作系统网格.jpg)

# 目录

- [B站演示视频](#b站演示视频)
- [配置清单](#配置清单)
- [为何选择这套配置](#为何选择这套配置)
  - [主板 + CPU](#主板--cpu)
  - [显卡](#显卡)
  - [无线网卡 + 蓝牙](#无线网卡--蓝牙)
- [黑苹果完美程度 (未测试需要 Apple ID 的功能)](#黑苹果完美程度-未测试需要-apple-id-的功能)
  - [正常工作](#正常工作)
  - [bug](#bug)
- [这台多系统博物馆计算机的可用性](#这台多系统博物馆计算机的可用性)
- [构建重点](#构建重点)
  - [BIOS 设置](#bios-设置)
    - [处理器设置](#处理器设置)
    - [显卡设置](#显卡设置)
    - [USB 设置](#usb-设置)
    - [CSM](#csm)
    - [安全启动](#安全启动)
  - [Bootloader 选择](#bootloader-选择)
  - [时间同步](#时间同步)
  - [核显驱动](#核显驱动)
  - [声卡驱动](#声卡驱动)
  - [有线网卡驱动](#有线网卡驱动)
  - [独显驱动](#独显驱动)
  - [电源管理](#电源管理)
    - [通用修复](#通用修复)
    - [macOS 13 及以上版本额外添加](#macos-13-及以上版本额外添加)
  - [AppleVTD](#applevtd)
  - [OS X 10.8 下实现 4K 60hz Hidpi](#os-x-108-下实现-4k-60hz-hidpi)
    - [实现方案](#实现方案)
      - [至此，您已经成功的在 10.8 下实现了 4K 60hz hidpi。](#至此您已经成功的在-108-下实现了-4k-60hz-hidpi)
  - [关于 macOS 12-macOS 26](#关于-macos-12-macos-26)
  - [SMBIOS 选择](#smbios-选择)
    - [安装系统](#安装系统)
    - [安装完成](#安装完成)
- [2025.11.15 更新](#20251115-更新)
- [2026.5.24更新](#2026524更新)
  - [使用第三方 OC 主题，提升美观程度](#使用第三方-oc-主题提升美观程度)
  - [解决 10.8 必须切换到 10.9 (或关机)，再切换其他系统，否则其他系统 wifi 失效的问题](#解决-108-必须切换到-109-或关机再切换其他系统否则其他系统-wifi-失效的问题)
    - [至此，随便切换系统，wifi 也不会失效了。](#至此随便切换系统wifi-也不会失效了)
  - [解决 10.8-10.11 关于本机不显示年份的问题](#解决-108-1011-关于本机不显示年份的问题)
  - [解决 csm 中开启 Video Legacy 以后，OC 选择界面分辨率极低，macOS 启动 logo 扁平，Windows 启动 logo 偏移向左上角等问题](#解决-csm-中开启-video-legacy-以后oc-选择界面分辨率极低macos-启动-logo-扁平windows-启动-logo-偏移向左上角等问题)
    - [至此，已完成自动化设置 bios 的第一启动项并且控制 csm 中的 video 选项，OpenShell.efi 会自动运行同分区根目录的 startup.nsh 脚本。](#至此已完成自动化设置-bios-的第一启动项并且控制-csm-中的-video-选项openshellefi-会自动运行同分区根目录的-startupnsh-脚本)
- [2026.5.31更新](#2026531更新)
  - [老系统浏览器](#老系统浏览器)
    - [Windows](#windows)
    - [Mac OS X/OS X/macOS](#mac-os-xos-xmacos)
- [2026.6.3 更新](#202663-更新)
  - [解锁 CFG Lock](#解锁-cfg-lock)
    - [所需设备](#所需设备)
    - [所需工具 (位于仓库中的 bios 文件夹)](#所需工具-位于仓库中的-bios-文件夹)
    - [修改 BIOS (解锁 CFG Lock 并解锁部分隐藏选项)](#修改-bios-解锁-cfg-lock-并解锁部分隐藏选项)
      - [至此，解锁了 CFG Lock、CSM 下的 video 选项以及 Intel VT-d 的修改版 BIOS 已制作完成](#至此解锁了-cfg-lockcsm-下的-video-选项以及-intel-vt-d-的修改版-bios-已制作完成)
    - [刷写修改版 BIOS](#刷写修改版-bios)
    - [至此，修改版 BIOS 已经刷写成功，CFG Lock 已经成功解锁，请在 OC 的 config 中禁用 Kernel-\>Quirks 下的 AppleCpuPmCfgLock 以及 AppleXcpmCfgLock 两个选项](#至此修改版-bios-已经刷写成功cfg-lock-已经成功解锁请在-oc-的-config-中禁用-kernel-quirks-下的-applecpupmcfglock-以及-applexcpmcfglock-两个选项)
- [引导器截图](#引导器截图)
  - [OpenCore](#opencore)
  - [XorBoot](#xorboot)
- [系统桌面截图](#系统桌面截图)


# B站演示视频

[在一台 ivy bridge 计算机上安装 20 个操作系统版本 (内录 4K Retina 呈现，推荐电脑全屏观看)\_哔哩哔哩\_bilibili](https://www.bilibili.com/video/BV1QkGX6qE9q)

# 配置清单

- 主板： 华硕 P8Z77M-Pro

- CPU： i7-3770

- 内存： 16g ddr3 1600mhz

- 显卡： Nvidia GTX770

- SSD1：三星 870evo SATA 256g

- SSD2：三星 870evo SATA 2T

- 无线网卡 1：Fenvi-T919

- 无线网卡 2：BCM94331CSAX

- 显示器：Dell S2725QS 4K

- 机箱：乔思伯 D32 Pro Mesh 版

- 操作系统：Windows XP-Windows11

- 操作系统：OS X Mountain Lion-macOS Tahoe

# 为何选择这套配置

## 主板 + CPU

> 要同时兼容如此多的操作系统，首先要考虑一个特殊的 Windows 版本，即 Windows Vista。Windows Vista 最新原生支持的平台是 ivy bridge。Haswell 可以安装 XP 却无法稳定运行 Vista，Haswell 下的 Vista 会随机报错。所以要全面兼容 winxp-win11 以及 OS X 10.8-macOS 26，可以选择的最新平台就是 ivy bridge。黑苹果方面，ivy bridge 原生支持 OS X 10.7-macOS 11。macOS 12-macOS 26 可以用 oclp 搞定。因为黑苹果需求，AMD 处理器也不建议选择。

## 显卡

> 根据 Dortania 的 OpenCore 文档，Kepler 架构的 Nvidia 显卡可以原生支持 OS X 10.8-macOS 11，更新版本用 oclp 搞定。Kepler 也完美支持 XP-Win11。文档中还提到 AMD 的 HD 7000 系列和 HD 8000 系列可以原生支持 OS X 10.8-macOS 12，但笔者亲测，HD 7750 在 OS X 10.8.5 下，无法进入桌面，仅显示白屏 + 鼠标指针。网络上有遇到同样问题的。链接如下：https://www.insanelymac.com/forum/topic/290733-hd-7950-doesnt-work-on-mac-os-x-1084/ 。

## 无线网卡 + 蓝牙

> 根据 Dortania 的 OpenCore 文档，Fenvi-T919 是很好的黑苹果无线网卡，无线 + 蓝牙原生免驱，Windows 下 win7-win11 也没问题。XP/Vista 的 wifi / 蓝牙也不重要了。但是要注意 Fenvi-T919 在 10.8 下有严重 bug。重启只能进入 10.9 (或关机) 再切换其他系统，否则其他系统 wifi 会失效 (包括 Windows)，所以需要一张单独用于 10.8 的无线网卡并在 10.8 下屏蔽 Fenvi-T919，笔者选择的 bcm94331csax，很便宜，10.8 下完美免驱。这张卡我们不插蓝牙线，形成双无线网卡 + 单蓝牙架构，BCM94331CSAX 的 wifi 还可以在 XP 下用。后文会详解如何使用 SSDT 根据系统版本屏蔽多余无线网卡，实现 OS X 10.8 下使用 单蓝牙架构，BCM94331CSAX，OS X 10.9-macOS 26 下使用 Fenvi-T919。

# 黑苹果完美程度 (未测试需要 Apple ID 的功能)

## 正常工作

* 声卡

* 核显

* 独显

* 4K hidpi显示

* 有线网卡

* WiFi

* 蓝牙

* 睡眠

* 唤醒

* USB

* 变频

* AppleVTD

* CFG Lock解锁 

## bug

- ~~在 10.8 下切换系统，必须先切换到 10.9 (或关机) 再切换到其他系统，否则其他系统搜不到 WIFI 信号 (包括 Windows)，10.8 系统会把华硕 BE86U 的 5Ghz WiFi 识别成企业级无法使用，连接 2.4Ghz WIFI 正常。~~   已修复。
- 10.8 系统较老，不识别 WPA2/WPA3-Personal 协议。设置一个使用 WPA2 协议的 SSID 专供老系统使用即可。

# 这台多系统博物馆计算机的可用性
> 不考虑生产力，只作为玩具，考虑系统级流畅度的情况下。winxp-win11 以及 OS X 10.8-macOS 12 都是高度可用的，非常流畅。macOS 13-macOS 26 流畅度显著下降，不支持 AVX 2.0 指令集是一个无法逾越的鸿沟。

# 构建重点

## BIOS 设置

### 处理器设置

- VT-d-> 开启 (笔者的主板 BIOS 没有此选项，但默认开启了)

### 显卡设置

- 首选显卡 -> PCIE

- iGPU 内存 -> 128M

- 初始化 IGPU -> 开启

### USB 设置

- Intel USB 2.0 EHCI Controller -> 开启

- Legacy USB 支持 -> 开启

- Legacy USB 3.0 支持 -> 开启

- Intel xHCI 模式 -> 自动 (开启会导致 xp/vista 的 USB 3.0 失效)

- EHCI Hand-off -> 开启

### CSM

- 启动设备控制 -> UEFI 与 Legacy

### 安全启动

- 操作系统类型 -> 其他操作系统

## Bootloader 选择

- ~~OpenCore 用于引导黑苹果以及 refind~~
  
  - ~~OpenCore 添加 refind 启动项~~
    
    ~~Misc->BlessOverride 下加入条目 \EFI\EFI\refind\refind\_x64.efi 即可~~
  
  - ~~refind 用于引导 mbr 分区表上的 Windows XP~~
    
    ```diff
    - timeout -1 #隐藏refind ui，直接进入目标系统
    - scanfor manual hdbios #仅搜索传统bios引导项
    - dont_scan_volumes "2TB" #删除不需要的引导项，禁止扫描指定硬盘(引号里添加引导项名称的子集)
    ```

- OpenCore 用于引导 OS X 10.8-macOS 26 以及 OpenShell 工具
  
  - 将仓库中的 .contentVisibility 文件拷贝到 vista/win7 的 EFI/Microsoft/Boot 目录中以在 OC 选择菜单中隐藏 vista/win7。
  
  - 将仓库中的 .contentDetails 文件拷贝到 win8-win11 的 EFI/Microsoft/Boot 目录中，并且修改其内容，如 Windows 8，即可自定义 OC 选择菜单中 Windows 系统名称。
  
  - 将仓库中的 .contentFlavour 文件拷贝到 win8-win11 的 EFI/Microsoft/Boot 目录中，并且修改其内容，如 Windows8:Windows，即可自定义 OC 选择菜单中 Windows 系统的图标，假定系统图标名为 Windows8.icns。

- xorboot 用于引导 Legacy 系统 (vista,win7)、refind (启动 xp) 以及 OpenShell 工具
  
  - xorboot 的安装使用极其简单，完全 GUI 配置，0 代码，添加 vista 和 win7 的 bootmgfw.efi 文件、refind 的 refind\_x64.efi 文件以及 OpenShell.efi 工具条目即可。
  
  - refind.conf 重要设置
    
    ```
    timeout -1 #隐藏refind ui，直接进入目标系统
    scanfor manual hdbios #仅搜索传统bios引导项以及手动设置项
    dont_scan_volumes "2TB" #删除不需要的引导项，禁止扫描指定硬盘(引号里添加引导项名称的子集)
    uefi_deep_legacy_scan 1 #建议设置，否则可能找不到xp系统
    ```

- OpenShell 工具及其重要，后面讲。

## 时间同步

- 在 Windows 下导入仓库中的 WinUTCOn.reg 文件，重启即可解决 Windows 时间不对的问题。

## 核显驱动

- 加入 Whatevergreen.kext

- 按照下图注入 igpu 信息即可，设备地址用 Hackintool 获取
  
  ![](images/OpenCore/igpu.jpg)

## 声卡驱动

- 10.8
  
  > 华硕的 P8Z77M-Pro 主板的声卡是 ALC892，AppleALC 对于此声卡的支持起始于 10.9，笔者自行修改编译了支持 ALC892 声卡在 10.8 下使用的 AppleALC，在 EFI 里，直接用即可。(已经向原作者提交了 pr，希望能够合并到主分支，链接如下：https://github.com/acidanthera/AppleALC/pull/947)
  > 
  > ---
  > 
  > 2026.5.24 更新：原作者已将 pr 合并到主分支，直接下载最新的官方 AppleALC 即可。

- 加入 AppleALC.kext
  
  按照下图注入 HDA 信息即可，设备地址用 Hackintool 获取
  
  ![](images/OpenCore/hda.jpg)

## 有线网卡驱动

- 按照如下版本要求加入 RealtekRTL8111.kext 即可
  - OS X 10.8-OS X 10.10 -> v1.2.3
  - OS X 10.11-macOS 10.14 -> v2.2.1
  - macOS 10.15-macOS 26 -> v3.0.4
  ![](images/OpenCore/lan.jpg)  


## 独显驱动

- 加入 Whatevergreen.kext。无需任何其他配置。

## 电源管理

### 通用修复

- 按照下图启用如下补丁
  
  ![](images/OpenCore/pm2.jpg)

- 运行仓库中的 ssdtPRGen.sh 生成 SSDT，重命名为 SSDT-PM.aml，加入到 OC 的 ACPI 文件夹并在 config 中启用。

- 禁用刚才启用的补丁
  
  ![](images/OpenCore/pm1.jpg)

### macOS 13 及以上版本额外添加

> macOS 13 起，Apple 移除了 AppleIntelCPUPowerManagement，所以 ivy bridge 平台需要自行加入以下 Kexts 以恢复电源管理。

![](images/OpenCore/pm3.jpg)

## AppleVTD

> 在新系统上 (如 macOS 13)，Intel VT-d 的开启变得非常重要，如不开启，可能导致网卡失效。雷电设备也和 VT-d 高度相关，下面是开启教程。

- 在 BIOS 中开启 vt-d 选项

- 在 OC 的 Kernel->Patch 中禁用 DisableIoMapper 选项并重启
  
  ![](images/AppleVTD/vtd1.jpg)

- 用 MaciASL 导出 DMAR 表并另存为 dsl 格式
  
  ![](images/AppleVTD/vtd2.jpg)
  
  ![](images/AppleVTD/vtd3.jpg)

- 打开 dsl 文件。删除所有 \[Reserved Memory Region] 区域并另存为 SSDT-DMAR，格式选择 aml
  
  ![](images/AppleVTD/vtd4.jpg)
  
  ![](images/AppleVTD/vtd5.jpg)

- 将 SSDT-DMAR.aml 放入 OC 的 ACPI 文件夹中并在 config 中启用
  
  ![](images/AppleVTD/vtd6.jpg)

- 在 OC 的 config 中，找到 ACPI->Delete，加入如下条目以阻止原生 DMAR 表载入
  
  ![](images/AppleVTD/vtd7.jpg)

- 重启，打开 ioreg 工具，如图则为 AppleVTD 加载成功
  
  ![](images/AppleVTD/vtd8.jpg)

## OS X 10.8 下实现 4K 60hz Hidpi

> 首先 Mac 系统是在 10.9.3 开始正式支持的 4K 60hz hidpi，10.7 和 10.8 只支持低分辨率的 Retina，但是物理分辨率无法输出 4K，因为当时的白苹果配备的显卡也没有支持 4K 输出的，黑苹果可用显卡要输出 4K，最早的是 Nvidia GTX 600 系列，而 600 系列支持的最初版 Mac 系统是 10.8，故而想要实现 4K 60hz hidpi，最起码需要 10.8 系统起步，显卡支持 4K 输出是最基本的前提要求。因为 10.8 没有原生支持 4K 输出，所以要通过第三方方案实现 4K 60hz hidpi。

### 实现方案

> 由于笔者的 GTX 770 在 10.8 下最高只能识别 2K 分辨率，所以要先解决 4K 输出，再通过命令开启 hidpi，具体方案如下。

- 安装 Nvidia webdriver，仓库里已经提供。

- 在 OpenCore 的 NVRAM->Add->7C436110-AB2A-4BBB-A880-FE41995C9F82->boot-args 下添加 nvda\_drv=1，重启。至此已经实现 10.8 下的 4K 输出。

- 输入如下命令并重启开启 10.8 下的 hidpi
  
  ```bash
  sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool YES
  ```

- 设置 -> 显示器里面有两个 1080p，一个一个测试，有一个是 hidpi (因为毕竟是第三方方案，多少有点 bug，所幸效果非常完美)。

#### 至此，您已经成功的在 10.8 下实现了 4K 60hz hidpi。

## 关于 macOS 12-macOS 26

> 这一套硬件配置原生支持截止到 macOS 11，macOS 12 缺失了 Intel hd 4000 以及 Nvidia GTX 770 的驱动。macOS 13 在前者的基础上，缺失了 AVX2 指令集，macOS 14 和 macOS 15 在前者基础上缺失了博通的网卡驱动，macOS 26 在前者的基础上缺失了 AppleHDA，本章我们解决这些问题。

- 在 OC 的 NVRAM 下设置如下 boot-args (macOS 26 必须加入 - amfipassbeta)
  
  ![](images/OpenCore/oclp1.jpg)

- 在 OC 的 NVRAM 下设置如下条目以关闭 SIP
  
  ![](images/OpenCore/oclp2.jpg)

- 在 OC 的 Misc 下关闭安全启动
  
  ![](images/OpenCore/oclp3.jpg)

- 按照下图加入 Kexts 并在 config 中根据系统版本启用 (注意顺序)
  
  ![](images/OpenCore/oclp4.jpg)

- 按照下图根据系统版本禁用内置 kext
  
  ![](images/OpenCore/oclp5.jpg)

- 重启

- 使用 oclp 打补丁并重启 (macOS 26 必须用 oclp 3.0.0 RC 版本)

> 至此，您的 macOS 12-macOS 26 系统已完全正常

## SMBIOS 选择

### 安装系统

请选择系统版本支持的SMBIOS

### 安装完成

- 设置 SMBIOS 为 iMac13,2

- 在 OpenCore 下加入如图补丁以跳过 board-id 检查 (EFI 文件夹里有完整的 config.plist 文件)
  
  ![](images/OpenCore/Skip%20Board%20ID%20check.jpg)

# 2025.11.15 更新

* 删除 refind 无用文件夹，修复 refind 进入极慢的 bug (B 站视频已经更新)

* 修复 OS X 10.9 启动无 logo，直到登录界面才亮屏的 bug (B 站视频已经更新)

# 2026.5.24更新

## 使用第三方 OC 主题，提升美观程度

* 见EFI

## 解决 10.8 必须切换到 10.9 (或关机)，再切换其他系统，否则其他系统 wifi 失效的问题

> 这个问题的成因是 OS X 10.8 的 94630 驱动自身有 bug，不完美，据说当年的 iMac 在 10.8 上用过 94360，镜像是定制的，我没下载到。于是我添加了一张 BCM94331CSAX 专门用于 OS X 10.8。

- 添加一张 BCM94331CSAX 网卡，不插蓝牙线，这张卡的 wifi，将用于 OS X 10.8 和 XP (XP 没有 96360 的驱动)。蓝牙方面，所有系统用 Fenvi-T919 的蓝牙，即双无线网卡 + 单蓝牙架构

- 在 OC 的 Kernel Patch 下添加如下条目以实现 macOS 版本区分 (10.8->Darw12，其他->Darwin)
  
  ![](images/OpenCore/Change%20_OSI%20from%20Darwin%20to%20Darw12.jpg)

- 加入如下 SSDT 以根据系统版本禁用多余网卡 (10.8 禁用 Fenvi-T919，其他 macOS 禁用 BCM94331CSAX)，路径在 ioreg 工具中查看并在 SSDT 中修改。
  
  ```
  DefinitionBlock ("", "SSDT", 2, "HACK", "WIFISEL", 0x00000000)
  {
      External (_SB_.PCI0.PEG1, DeviceObj)
      External (_SB_.PCI0.RP01.PXSX, DeviceObj)
  
      Scope (_SB.PCI0.RP01.PXSX)
      {
          Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
          {
              If ((Arg2 == Zero))
              {
                  Return (Buffer (One)
                  {
                       0x03                                           
                  })
              }
  
              If (_OSI ("Darw12"))
              {
                  Return (Package (0x0C)
                  {
                      "device-id", 
                      Buffer (0x04)
                      {
                           0xFF, 0xFF, 0x00, 0x00                           
                      }, 
  
                      "vendor-id", 
                      Buffer (0x04)
                      {
                           0xFF, 0xFF, 0x00, 0x00                           
                      }, 
  
                      "class-code", 
                      Buffer (0x04)
                      {
                           0xFF, 0xFF, 0xFF, 0xFF                           
                      }, 
  
                      "compatible", 
                      "pci14e4,ffff", 
                      "name", 
                      "pci14e4,ffff", 
                      "model", 
                      "94360 Disabled for 10.8"
                  })
              }
  
              Return (Package (0x02)
              {
                  "model", 
                  "BCM4360 802.11ac Wireless"
              })
          }
      }
  
      Scope (_SB.PCI0.PEG1)
      {
          Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
          {
              If ((Arg2 == Zero))
              {
                  Return (Buffer (One)
                  {
                       0x03                                             
                  })
              }
  
              If (_OSI ("Darwin"))
              {
                  Return (Package (0x0C)
                  {
                      "device-id", 
                      Buffer (0x04)
                      {
                           0xFF, 0xFF, 0x00, 0x00                           
                      }, 
  
                      "vendor-id", 
                      Buffer (0x04)
                      {
                           0xFF, 0xFF, 0x00, 0x00                           
                      }, 
  
                      "class-code", 
                      Buffer (0x04)
                      {
                           0xFF, 0xFF, 0xFF, 0xFF                           
                      }, 
  
                      "compatible", 
                      "pci14e4,ffff", 
                      "name", 
                      "pci14e4,ffff", 
                      "model", 
                      "94331 Disabled for Modern OS"
                  })
              }
  
              Return (Package (0x02)
              {
                  "model", 
                  "BCM4331 802.11n Wireless"
              })
          }
      }
  }
  ```

- 在 config 中启用以上 SSDT。

- 在其他需要判断 OS 类型的 SSDT 中，将 If (\_OSI ("Darwin")) 改成 If ((\_OSI ("Darwin") || \_OSI ("Darw12")))

### 至此，随便切换系统，wifi 也不会失效了。

## 解决 10.8-10.11 关于本机不显示年份的问题

> macOS 关于本机的年份是通过 API 返回的，这些系统由于年代久远，已无法正常访问 API 网站，所以我们要手动编辑本地文件以添加年份。

- 在正常工作的现代操作系统上运行如下命令以获取应该显示的内容 (cc=xxxx，xxxx 为所选机型序列号后四位，10.11 以及更早系统访问的 API 有语言参数，10.12 开始没有了，所以老 OS X 版本关于本机的年份是系统语言，新版是英文)
  
  ```
  curl -s "https://support-sp.apple.com/sp/product?cc=DNCW&lang=zh-Hans_CN" | sed -n 's/.*<configCode>\(.*\)<\/configCode>.*/\1/p'
  ```

- 记录返回值，如 iMac (27 英寸，2012 年末)

- 打开 SMBIOS 年份修复文件夹中的的 plist 文件，注意系统版本，修改序列号后四位，语言，机型三个信息。修改好的类似下图，两张图分别为 10.8 的和 10.9-10.11 的
  
  ![](images/SMBIOS/10.8.jpg)  
  
  ![](images/SMBIOS/10.9-10.11.jpg)

- 将改好的 plist 文件覆盖到 \~/Library/Preferences 并重启，你会发现 OS X 10.8-10.11 的关于本机年份恢复了

## 解决 csm 中开启 Video Legacy 以后，OC 选择界面分辨率极低，macOS 启动 logo 扁平，Windows 启动 logo 偏移向左上角等问题

> 众所周知，xp/vista/win7 是不能在纯 UEFI 模式下启动的，需要设置 csm 下的 video 为 legacy，这样做的代价是无法获得高清的主板 logo，Windows 启动 logo，macOS 启动 logo 以及引导器高清图标，并且 Windows 启动 logo 会偏移到左上角，macOS 启动 logo 会扁平。现在我们解决这个问题。

> 前提：1 机器支持 UEFI    2 显卡支持 UEFI 或者刷过 vbios 以支持 UEFI

> 核心思路：永远不要想着在纯 UEFI 下启动 xp/vista/win7。我们使用 OC 引导 win8-win11 以及 OS X 10.8-macOS 26，csm 的 video 设置为 UEFI。使用 xorboot 引导 xp/vista/win7，csm 的 video 设置为 legacy，这样自然是完美的，传统操作系统和现代操作系统各得其所。但是需要修改 bios 设置和第一启动项，很麻烦，我们要做的就是把这个修改 bios 设置和第一启动项的动作自动化。

- 升级显卡的 GOP 模块 (如果你的显卡在纯 UEFI 下可以点亮并且可以全高清显示 OC 图标，Windows/macOS 的启动 logo 也不会偏移，扁平，则跳过此步骤。笔者的 GTX 770 开纯 UEFI 点不亮)
  
  - 用 GPU-Z 导出显卡 vbios
  
  - 打开仓库中的 GOP\_Updater，将 vbios 文件拖拽到 GOPupd.bat 上，按照提示升级 GOP 模块，会生成一个新的 vbios，把它重命名为 1.rom 以方便刷写
  
  - 使用 nvflash 刷写新的 vbios，Windows 打开管理员模式的终端，输入如下命令
    
    > nvflash.exe -6 1.rom

- 到主板官网下载 bios，用 set\_dump GUI 打开，搜索 csm 下面 video 的偏移量，笔者的是 0x8CE，并且注意 legacy only 和 UEFI only 分别对应的数字如下图，UEFI only 0x1，legacy only 0x2
  
  ![](images/csm.jpg)

- 修改 BIOS 设置，将 csm 打开，启动设备控制选择 UEFI and Legacy，这样可以保证 mbr 下的 xp 系统的启动。并且把第一第二启动项分别设置为 OC 和 xorboot。

- 准备 startup.nsh 脚本，这个脚本做两件事
  
  - 用 setup\_var 修改 csm 中的 video 选项，如
    
    ```
    setup_var.efi -r Setup:0x8CE=0x02
    ```
  
  - 利用重命名 efi 文件的方法，修改第一启动项为 OC 或 xorboot，完整脚本如下
    
    ```
    @echo -off
    
    # 寻找包含我们工具包的分区
    for %i in fs0 fs1 fs2 fs3 fs4 fs5
        if exist %i:\EFI\tools\setup_var.efi then
            # 锁定当前分区
            %i:
            goto FOUND
        endif
    endfor
    
    echo "Error: Tools partition not found."
    goto END
    
    :FOUND
    
    # 判断当前模式
    if exist EFI\OC\OpenCore.efi then
       # csm video切legacy
       # 备份OC
       mv EFI\OC\OpenCore.efi EFI\OC\OpenCore.efi.bak > nul
       # 恢复 xorboot
       if exist EFI\xorboot\xorboot.efi.bak then
          mv EFI\xorboot\xorboot.efi.bak EFI\xorboot\xorboot.efi > nul
       endif
       # 修改 BIOS 变量 (Video -> Legacy)
       EFI\tools\setup_var.efi -r Setup:0x8CE=0x02 > nul
    else
       # csm video切uefi
       # 恢复OC
       if exist EFI\OC\OpenCore.efi.bak then
          mv EFI\OC\OpenCore.efi.bak EFI\OC\OpenCore.efi > nul
       endif
       # 备份xorboot
       if exist EFI\xorboot\xorboot.efi then
          mv EFI\xorboot\xorboot.efi EFI\xorboot\xorboot.efi.bak > nul
       endif
       # 修改 BIOS 变量 (Legacy -> UEFI)
       EFI\tools\setup_var.efi -r Setup:0x8CE=0x01 > nul
    endif
    
    :END
    ```

- 脚本简单解释
  
  - 搜索存在 setup\_var.efi 的分区并锁定
  
  - 判断当前模式，如果存在 OpenCore.efi 文件，则说明当前 video 是 UEFI 模式，反之则为 legacy。
  
  - 基于当前模式执行不同操作
    
    - UEFI：将 OpenCore.efi 重命名为 OpenCore.efi.bak，将 xorboot 的 efi 文件名称还原回 xorboot.efi，相当于第一启动项改 xorboot，用 setup\_var.efi 将 video 设置成 legacy，会自动重启，自然进入 legacy 模式的 xorboot，进而启动 xp/vista/7。
    
    - legacy：将 OpenCore.efi.bak 还原为 OpenCore.efi，将 xorboot.efi 重命名为 xorboot.efi.bak，相当于第一启动项改 OC，用 setup\_var.efi 将 video 设置成 UEFI，会自动重启，自然进入 UEFI 模式的 OC，进而启动现代系统。

- 将 startup.nsh 放到 EFI 分区 (和 OpenShell.efi 文件同分区) 根目录，和 EFI 文件夹同层级

- 在 OC 的 Tools 文件夹中加入 OpenShell.efi 文件并在 config 中添加此条目，参数为 -nointerrupt -noconsolein -noconsoleout
  
  ![](images/OpenCore/OpenShell.jpg)

- 在 xorboot 中加入 OpenShell 条目，参数同上
  
  ![](images/xorboot/xorboot1.jpg)

### 至此，已完成自动化设置 bios 的第一启动项并且控制 csm 中的 video 选项，OpenShell.efi 会自动运行同分区根目录的 startup.nsh 脚本。

# 2026.5.31更新
## 老系统浏览器
### Windows
- supermium(Windows XP, 2003, Vista, 7, 8 and 8.1) https://github.com/win32ss/supermium

### Mac OS X/OS X/macOS
- chromium-legacy(Mac OS X 10.7，OS X 10.8-10.11，macOS 10.12-10.14) https://github.com/blueboxd/chromium-legacy

# 2026.6.3 更新

## 解锁 CFG Lock
> 笔者的主板是 ASUS P8Z77M Pro，这款主板无法搜索出 CFG Lock 的偏移量，所以需要修改 BIOS 并刷入以解锁 CFG Lock，笔者在仓库中提供了解锁后的 BIOS，位于 bios 文件夹中。
### 所需设备
- U 盘 1 个

### 所需工具 (位于仓库中的 bios 文件夹)
* UEFIPatch
* AMIBCP
* UEFITool

### 修改 BIOS (解锁 CFG Lock 并解锁部分隐藏选项)
> 在 Windows11 下操作

- 下载官方 BIOS 文件备用
- 将官方 BIOS 重命名为 bios.CAP 并拷贝到 UEFIPatch 文件夹
![](images/bios/bios1.png)
- 在当前目录打开终端并输入如下命令以解锁 CFG Lock，解锁后的文件位于同目录，名为 bios.CAP.patched
  ```
  .\UEFIPatch.exe .\bios.CAP
  ```
  ![](images/bios/bios2.png)
  ![](images/bios/bios3.png)
- 将 bios.CAP.patched 重命名为 P8Z77MP\_UNLOCK.CAP
- 用 AMIBCP 打开 P8Z77MP\_UNLOCK.CAP，将需要解锁的选项 (如 CSM 下的 video 选项，intel vt-d 等) 的 Access/Use 设置为 USER 并保存
![](images/bios/bios5.png)
![](images/bios/bios4.png)
- 用 UEFITool 打开处理后的 P8Z77MP\_UNLOCK.CAP，导航到 BIOS region，点击右键，选择 Extract as is...，文件名填 1，点击保存。得到文件 1.rgn
![](images/bios/bios6.png)
![](images/bios/bios7.png)
![](images/bios/bios8.png)
- 用 UEFITool 打开官网下载的 BIOS，导航到 BIOS region，点击右键，选择 Replace as is..., 选择 1.rgn，点击打开
![](images/bios/bios9.png)
![](images/bios/bios10.png)
![](images/bios/bios11.png)
- 点击 File->Save image file, 名称为 P8Z77MP.CAP，点击保存
![](images/bios/bios12.png)
![](images/bios/bios13.png)

#### 至此，解锁了 CFG Lock、CSM 下的 video 选项以及 Intel VT-d 的修改版 BIOS 已制作完成

### 刷写修改版 BIOS

- U 盘格式化为 FAT32 格式，分区表类型为 MBR，将处理好的 P8Z77MP.CAP 拷贝到 U 盘根目录 (文件名必须正确)
- 将 U 盘插入如下 USB 口 (必须是这个口)
![](images/bios/bios14.png)
- 关机，打开机箱侧盖，按住下图中的 BIOS\_FLBK 按键 3s，黄灯开始闪烁，等待黄灯熄灭，BIOS 刷写成功。
![](images/bios/bios15.png)

### 至此，修改版 BIOS 已经刷写成功，CFG Lock 已经成功解锁，请在 OC 的 config 中禁用 Kernel->Quirks 下的 AppleCpuPmCfgLock 以及 AppleXcpmCfgLock 两个选项

# 引导器截图

## OpenCore

![](images/OpenCore/OC1.jpg)

![](images/OpenCore/OC2.jpg)

## XorBoot

![](images/xorboot/xorboot2.jpg)

# 系统桌面截图

![](images/desktop/xp.jpg)

![](images/desktop/vista.jpg)

![](images/desktop/win7.jpg)

![](images/desktop/win8.jpg)

![](images/desktop/win8.1.jpg)

![](images/desktop/win10.jpg)

![](images/desktop/win11.jpg)

![](images/desktop/osx%2010.8.jpg)

![](images/desktop/osx%2010.9.jpg)

![](images/desktop/osx%2010.10.jpg)

![](images/desktop/osx%2010.11.jpg)

![](images/desktop/macOS%2010.12.jpg)

![](images/desktop/macOS%2010.13.jpg)

![](images/desktop/macOS%2010.14.jpg)

![](images/desktop/macOS%2010.15.jpg)

![](images/desktop/macOS%2011.jpg)

![](images/desktop/macOS%2012.jpg)

![](images/desktop/macOS%2013.jpg)

![](images/desktop/macOS%2014.jpg)

![](images/desktop/macOS%2015.jpg)

![](images/desktop/macOS%2026.jpg)