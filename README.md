# ASUS-p8z77m-pro-Install-Hackintosh-OS-X-Mountain-Lion-to-macOS-Sequoia-and-WindowsXP-to-Windows11

> macOS 26是Intel Mac可以使用的最后一个macOS版本，在即将到来的WWDC 2026上，Apple将发布macOS 27，届时将仅支持Apple Silicon Macs。在黑苹果即将成为历史的时刻，笔者在一台配备了4K显示器的ivy bridge计算机上以物理机的形式安装并运行了包括Windows XP-Windows11的所有Windows操作系统以及所有支持4K 60hz hidpi的intel macOS操作系统。

![](images/desktop/操作系统九宫格.jpg)
# 目录
- [B站演示视频](#b站演示视频)
- [配置清单](#配置清单)
- [为何选择这套配置](#为何选择这套配置)
  - [主板+CPU](#主板cpu)
  - [显卡](#显卡)
  - [无线网卡+蓝牙](#无线网卡蓝牙)
- [黑苹果完美程度(未测试需要Apple ID的功能)](#黑苹果完美程度未测试需要apple-id的功能)
  - [正常工作](#正常工作)
  - [bug](#bug)
- [构建重点](#构建重点)
  - [BIOS设置](#bios设置)
    - [处理器设置](#处理器设置)
    - [显卡设置](#显卡设置)
    - [USB设置](#usb设置)
    - [CSM](#csm)
    - [安全启动](#安全启动)
  - [Bootloader 选择](#bootloader-选择)
  - [时间同步](#时间同步)
  - [核显驱动](#核显驱动)
  - [声卡驱动](#声卡驱动)
  - [独显驱动](#独显驱动)
  - [电源管理](#电源管理)
  - [AppleVTD](#applevtd)
  - [10.8下实现4K 60hz Hidpi](#108下实现4k-60hz-hidpi)
    - [实现方案](#实现方案)
      - [至此，您已经成功的在10.8下实现了4K 60hz hidpi。](#至此您已经成功的在108下实现了4k-60hz-hidpi)
  - [关于macOS 12-macOS15](#关于macos-12-macos15)
  - [SMBIOS选择](#smbios选择)
    - [安装系统](#安装系统)
    - [安装完成](#安装完成)
- [2025.11.15更新](#20251115更新)
- [2026.5.24更新](#2026524更新)
  - [使用第三方OC主题，提升美观程度](#使用第三方oc主题提升美观程度)
  - [解决10.8必须切换到10.9(或关机)，再切换其他系统，否则其他系统wifi失效的问题](#解决108必须切换到109或关机再切换其他系统否则其他系统wifi失效的问题)
    - [至此，随便切换系统，wifi也不会失效了。](#至此随便切换系统wifi也不会失效了)
  - [解决10.8-10.11关于本机不显示年份的问题](#解决108-1011关于本机不显示年份的问题)
  - [解决csm中开启video legacy以后，OC选择界面分辨率极低，macOS启动logo扁平，Windows启动logo偏移向左上角等问题](#解决csm中开启video-legacy以后oc选择界面分辨率极低macos启动logo扁平windows启动logo偏移向左上角等问题)
    - [至此，已完成自动化设置bios的第一启动项并且控制csm中的video选项，OpenShell.efi会自动运行同分区根目录的startup.nsh脚本。](#至此已完成自动化设置bios的第一启动项并且控制csm中的video选项openshellefi会自动运行同分区根目录的startupnsh脚本)
- [2026.5.31更新](#2026531更新)
  - [老系统浏览器](#老系统浏览器)
    - [Windows](#windows)
    - [Mac OS X/OS X/macOS](#mac-os-xos-xmacos)
- [2026.6.3更新](#202663更新)
  - [解锁CFG Lock](#解锁cfg-lock)
    - [所需设备](#所需设备)
    - [所需工具(位于bios文件夹)](#所需工具位于bios文件夹)
    - [修改BIOS(解锁CFG Lock并解锁部分隐藏选项)](#修改bios解锁cfg-lock并解锁部分隐藏选项)
      - [至此，解锁了CFG Lock、CSM下的video选项以及Intel VT-d的修改版BIOS已制作完成](#至此解锁了cfg-lockcsm下的video选项以及intel-vt-d的修改版bios已制作完成)
    - [刷写修改版BIOS](#刷写修改版bios)
    - [至此，修改版BIOS已经刷写成功，CFG Lock已经成功解锁，请在OC的config中禁用Kernel-\>Quirks下的AppleCpuPmCfgLock以及AppleXcpmCfgLock两个选项](#至此修改版bios已经刷写成功cfg-lock已经成功解锁请在oc的config中禁用kernel-quirks下的applecpupmcfglock以及applexcpmcfglock两个选项)
- [引导器截图](#引导器截图)
  - [OpenCore](#opencore)
  - [XorBoot](#xorboot)
- [系统桌面截图](#系统桌面截图)


# B站演示视频

[在一台ivy bridge计算机上安装20个操作系统(内录4K Retina呈现，推荐电脑全屏观看)_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1QkGX6qE9q)

# 配置清单

* 主板： 华硕p8z77m-pro

* CPU： i7-3770

* 内存： 16g ddr3 1600mhz

* 显卡： nvidia gtx770

* SSD1：三星870evo sata 256g

* SSD2：三星870evo sata 2T

* 无线网卡1：fenvi-t919

* 无线网卡2：bcm94331csax

* 显示器：dell S2725QS 4K

* 机箱：乔思伯d32 pro mesh版

* 操作系统：Windows XP-Windows11

* 操作系统：OS X Mountain Lion-macOS Sequoia

# 为何选择这套配置

## 主板+CPU

> 要同时兼容如此多的操作系统，首先要考虑一个特殊的Windows版本，即Windows Vista。Windows Vista最新原生支持的平台是ivy bridge。Haswell可以安装XP却无法稳定运行Vista，Haswell下的Vista会随机报错。所以要全面兼容xp-win11以及OS X 10.8-macOS 15，可以选择的最新平台就是ivy bridge。黑苹果方面，ivy bridge原生支持OS X 10.7-macOS 11。macOS 12-macOS 15可以用oclp搞定。因为黑苹果需求，AMD处理器也不建议选择。

## 显卡

> 根据Dortania的OpenCore文档，Kepler架构的Nvidia显卡可以原生支持OS X 10.8-macOS 11，更新版本用oclp搞定。Kepler也完美支持XP-Win11。文档中还提到AMD的HD 7000系列和HD 8000系列可以原生支持OS X 10.8-macOS 12，但笔者亲测，HD 7750在OS X 10.8.5下，无法进入桌面，仅显示白屏+鼠标指针。网络上有遇到同样问题的。链接如下：https://www.insanelymac.com/forum/topic/290733-hd-7950-doesnt-work-on-mac-os-x-1084/。

## 无线网卡+蓝牙

> 根据Dortania的OpenCore文档，fenvi-t919是很好的黑苹果无线网卡，无线+蓝牙原生免驱，Windows下win7-win11也没问题。XP/Vista的wifi/蓝牙也不重要了。但是要注意fenvi-t919在10.8下有严重bug。重启只能进入10.9(或关机)再切换其他系统，否则其他系统wifi会失效(包括Windows)，所以需要一张单独用于10.8的无线网卡并在10.8下屏蔽fenvi-t919，笔者选择的bcm94331csax，很便宜，10.8下完美免驱。这张卡我们不插蓝牙线，形成双无线网卡+单蓝牙架构，bcm94331csax的wifi还可以在XP下用。后文会详解如何使用SSDT屏蔽多余无线网卡，实现OS X 10.8下使用bcm94331csax，OS X 10.9-macOS 15下使用fenvi-t919。

# 黑苹果完美程度(未测试需要Apple ID的功能)

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

* ~~在10.8下切换系统，必须先切换到10.9(或关机)再切换到其他系统，否则其他系统搜不到WIFI信号(包括Windows)，10.8系统会把华硕BE86U的5Ghz WiFi识别成企业级无法使用，连接2.4Ghz WIFI正常。~~   已修复。
* 10.8系统较老，不识别WPA2/WPA3-Personal协议。设置一个使用WPA2协议的SSID专供老系统使用即可。

# 构建重点

## BIOS设置

### 处理器设置

* VT-d->开启(笔者的主板BIOS没有此选项，但默认开启了)

### 显卡设置

* 首选显卡->PCIE

* iGPU内存->128M

* 初始化IGPU->开启

### USB设置

* Intel USB 2.0 EHCI Controller->开启

* Legacy USB 支持->开启

* Legacy USB 3.0 支持->开启

* Intel xHCI模式->自动(开启会导致xp/vista的USB 3.0失效)

* EHCI Hand-off->开启

### CSM

* 启动设备控制->UEFI 与 Legacy

### 安全启动

* 操作系统类型->其他操作系统

## Bootloader 选择

* ~~OpenCore 用于引导黑苹果以及refind~~ 
  
  * ~~OpenCore 添加refind启动项~~
    
    ~~Misc->BlessOverride 下加入条目 \EFI\EFI\refind\refind_x64.efi 即可~~
  
  * ~~refind用于引导mbr分区表上的Windows XP~~    
    
    ```diff
    - timeout -1 #隐藏refind ui，直接进入目标系统
    - scanfor manual hdbios #仅搜索传统bios引导项
    - dont_scan_volumes "2TB" #删除不需要的引导项，禁止扫描指定硬盘(引号里添加引导项名称的子集)
    ```

* OpenCore用于引导OS X 10.8-macOS 15以及OpenShell工具
  
  * 将仓库中的.contentVisibility文件拷贝到vista/win7的EFI/Microsoft/Boot中以在OC选择菜单中隐藏vista/win7。
  
  * 将仓库中的.contentDetails文件拷贝到 win8-win11的EFI/Microsoft/Boot中，并且修改其内容，如Windows 8，即可自定义OC选择菜单中Windows系统名称。
  
  * 将仓库中的 .contentFlavour文件拷贝到 win8-win11的EFI/Microsoft/Boot中，并且修改其内容，如Windows8:Windows，即可自定义OC选择菜单中Windows系统的图标，假定系统图标名为Windows8.icns。

* xorboot用于引导legacy系统(vista,win7)、refind(启动xp)以及OpenShell工具
  
  * xorboot的安装使用极其简单，完全GUI配置，0代码，添加vista和win7的bootmgfw.efi文件、refind的refind_x64.efi文件以及OpenShell.efi工具即可。
  
  * refind.conf 重要设置
    
    ```
    timeout -1 #隐藏refind ui，直接进入目标系统
    scanfor manual hdbios #仅搜索传统bios引导项以及手动设置项
    dont_scan_volumes "2TB" #删除不需要的引导项，禁止扫描指定硬盘(引号里添加引导项名称的子集)
    uefi_deep_legacy_scan 1 #建议设置，否则可能找不到xp
    ```

* OpenShell工具及其重要，后面讲。

## 时间同步

- 在Windows下导入仓库中的WinUTCOn.reg文件，重启即可解决Windows时间不对的问题。

## 核显驱动

* 加入Whatevergreen.kext

* 按照下图注入igpu信息即可，设备地址用Hackintool获取
  
  ![](images/OpenCore/igpu.jpg)

## 声卡驱动

* 10.8
  
  > 华硕的 p8z77m-pro主板的声卡是alc892，AppleALC对于此声卡的支持起始于10.9，笔者自行修改编译了支持alc892声卡在10.8下使用的AppleALC，在EFI里，直接用即可。(已经向原作者提交了pr，希望能够合并到主分支，链接如下：https://github.com/acidanthera/AppleALC/pull/947)
  > 
  > ---
  > 
  > 2026.5.24更新：原作者已将pr合并到主分支，直接下载最新的官方AppleALC即可。

* 加入AppleALC.kext
  
  按照下图注入hda信息即可，设备地址用Hackintool获取
  
  ![](images/OpenCore/hda.jpg)

## 独显驱动

* 加入Whatevergreen.kext。无需任何其他配置。

## 电源管理

* 按照下图启用如下补丁
  
  ![](images/OpenCore/pm2.jpg)

* 运行仓库中的ssdtPRGen.sh生成SSDT，重命名为SSDT-PM.aml，加入到OC的ACPI文件夹并在config中启用。

* 禁用刚才启用的补丁
  
  ![](images/OpenCore/pm1.jpg)

## AppleVTD

> 在新系统上(如macOS 13)，Intel VT-d的开启变得非常重要，如不开启，可能导致网卡失效。雷电设备也和VT-d高度相关，下面是开启教程。

* 在BIOS中开启vt-d选项

* 在OC的Kernel->Patch中禁用DisableIoMapper选项并重启
  
  ![](images/AppleVTD/vtd1.jpg)

* 用MaciASL导出DMAR表并另存为dsl格式
  
  ![](images/AppleVTD/vtd2.jpg)
  
  ![](images/AppleVTD/vtd3.jpg)

* 打开dsl文件。删除所有[Reserved Memory Region]区域并另存为SSDT-DMAR，格式选择aml
  
  ![](images/AppleVTD/vtd4.jpg)
  
  ![](images/AppleVTD/vtd5.jpg)

* 将SSDT-DMAR.aml放入OC的ACPI文件夹中并在config中启用
  
  ![](images/AppleVTD/vtd6.jpg)

* 在OC的config中，找到ACPI->Delete，加入如下条目以阻止原生DMAR表载入
  
  ![](images/AppleVTD/vtd7.jpg)

* 重启，打开ioreg工具，如图则为AppleVTD加载成功
  
  ![](images/AppleVTD/vtd8.jpg)

## 10.8下实现4K 60hz Hidpi

> 首先Mac系统是在10.9.3开始正式支持的4K 60hz hidpi，10.7和10.8只支持低分辨率的Retina，但是物理分辨率无法输出4K，因为当时的白苹果配备的显卡也没有支持4K输出的，黑苹果可用显卡要输出4K，最早的是Nvidia GTX 600系列，而600系列支持的最初版Mac系统是10.8，故而想要实现4K 60hz hidpi，最起码需要10.8系统起步，显卡支持4K输出是最基本的前提要求。因为10.8没有原生支持4K输出，所以要通过第三方方案实现4K 60hz hidpi。

### 实现方案

> 由于笔者的GTX 770 在10.8下最高只能识别2K分辨率，所以要先解决4K输出，再通过命令开启hidpi，具体方案如下。

* 安装Nvidia webdriver，仓库里已经提供。

* openCore NVRAM->Add->7C436110-AB2A-4BBB-A880-FE41995C9F82->boot-args下添加nvda_drv=1，重启。至此已经实现10.8下的4K输出。

* 输入如下命令并重启开启10.8下的hidpi
  
  ```bash
  sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool YES
  ```

* 设置->显示器里面有两个1080p，一个一个测试，有一个是hidpi (因为毕竟是第三方方案，多少有点bug，所幸效果非常完美)。

#### 至此，您已经成功的在10.8下实现了4K 60hz hidpi。

## 关于macOS 12-macOS15

> 这一套硬件配置原生支持截止到macOS 11，macOS 12缺失了Intel hd 4000以及Nvidia GTX 770的驱动。macOS 13在前者的基础上，缺失了AVX2指令集，macOS 14和macOS 15在前者基础上缺失了博通的网卡驱动，本章我们解决这些问题。

* OC的NVRAM下设置如下boot-args
  
  ![](images/OpenCore/oclp1.jpg)

* OC的NVRAM下设置如下条目以关闭sip
  
  ![](images/OpenCore/oclp2.jpg)

* OC的Misc下关闭安全启动
  
  ![](images/OpenCore/oclp3.jpg)

* 按照下图加入kexts并在config中根据系统版本启用(注意顺序)
  
  ![](images/OpenCore/oclp4.jpg)

* 按照下图根据系统版本禁用内置kext
  
  ![](images/OpenCore/oclp5.jpg)

* 重启

* 使用oclp打补丁并重启

> 至此，您的macOS 12-macOS 15系统已完全正常

## SMBIOS选择

### 安装系统

请选择系统版本支持的SMBIOS

### 安装完成

* 设置SMBIOS为iMac13,2

* OpenCore下加入如图补丁以跳过board-id检查(EFI文件夹里有完整的config.plist文件)
  
  ![](images/OpenCore/Skip%20Board%20ID%20check.jpg)

# 2025.11.15更新

* 删除refind无用文件夹，修复refind进入极慢的bug(B站视频已经更新)

* 修复OS X 10.9启动无logo，直到登录界面才亮屏的bug(B站视频已经更新)

# 2026.5.24更新

## 使用第三方OC主题，提升美观程度

* 见EFI

## 解决10.8必须切换到10.9(或关机)，再切换其他系统，否则其他系统wifi失效的问题

> 这个问题的成因是OS X 10.8的94630驱动自身有bug，不完美，据说当年的iMac在10.8上用过94360，镜像是定制的，我没下载到。于是我添加了一张bcm94331csax专门用于10.8。

* 添加一张bcm94331csax网卡，不插蓝牙线，这张卡的wifi，将用于OS X 10.8和XP(xp没有96360的驱动)。蓝牙方面，所有系统用fenvi-t919的蓝牙，即双无线网卡+单蓝牙架构

* 在OC的Kernel Patch下添加如下条目以实现macOS版本区分(10.8->Darw12，其他->Darwin)
  
  ![](images/OpenCore/Change%20_OSI%20from%20Darwin%20to%20Darw12.jpg)
  
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

* 在config中启用以上SSDT。

* 在其他需要判断OS类型的SSDT中，将If (_OSI ("Darwin"))改成If ((_OSI ("Darwin") || _OSI ("Darw12")))

### 至此，随便切换系统，wifi也不会失效了。

## 解决10.8-10.11关于本机不显示年份的问题

> macOS关于本机的年份是通过API返回的，这些系统由于年代久远，已无法正常访问API网站，所以我们要手动编辑本地文件以添加年份。

* 在正常工作的现代操作系统上运行如下命令以获取应该显示的内容(cc=xxxx，xxxx为所选机型序列号后四位，10.11以及更早系统访问的API有语言参数，10.12开始没有了，所以老OS X版本关于本机的年份是系统语言，新版是英文)
  
  ```
  curl -s "https://support-sp.apple.com/sp/product?cc=DNCW&lang=zh-Hans_CN" | sed -n 's/.*<configCode>\(.*\)<\/configCode>.*/\1/p'
  ```

* 记录返回值，如 iMac（27 英寸，2012 年末）

* 打开SMBIOS年份修复文件夹中的的plist文件，注意系统版本，修改序列号后四位，语言，机型三个信息。修改好的类似下图，两张图分别为10.8的和10.9-10.11的
  
  ![](images/SMBIOS/10.8.jpg)  
  
  ![](images/SMBIOS/10.9-10.11.jpg)

* 将改好的plist文件覆盖到 ~/Library/Preferences并重启，你会发现OS X 10.8-10.11的关于本机年份恢复了

## 解决csm中开启video legacy以后，OC选择界面分辨率极低，macOS启动logo扁平，Windows启动logo偏移向左上角等问题

> 众所周知，xp/vista/win7是不能在纯UEFI模式下启动的，需要设置csm下的video为legacy，这样做的代价是无法获得高清的主板logo，Windows启动logo，macOS启动logo以及引导器高清图标，并且Windows启动logo会偏移到左上角，macOS 启动logo会扁平。现在我们解决这个问题。

> 前提：1 机器支持UEFI    2 显卡支持UEFI或者刷过vbios以支持UEFI

> 核心思路：永远不要想着在纯UEFI下启动xp/vista/win7。我们使用OC引导win8-win11以及OS X 10.8-macOS 15，csm的video设置为UEFI。使用xorboot引导xp/vista/win7，csm的video设置为legacy，这样自然是完美的，传统操作系统和现代操作系统各得其所。但是需要修改bios设置和第一启动项，很麻烦，我们要做的就是把这个修改bios设置和第一启动项的动作自动化。

* 升级显卡的GOP模块(如果你的显卡在纯UEFI下可以点亮并且可以全高清显示OC图标，Windows/macOS的启动logo也不会偏移，扁平，则跳过此步骤。笔者的GTX 770开纯UEFI点不亮)
  
  * 用GPU-Z导出显卡vbios
  
  * 打开仓库中的GOP_Updater，将vbios文件拖拽到GOPupd.bat上，按照提示升级GOP模块，会生成一个新的vbios，把它重命名为1.rom以方便刷写
  
  * 使用nvflash刷写新的vbios，Windows打开管理员模式的终端，输入如下命令
    
    > nvflash.exe -6 1.rom

* 到主板官网下载bios，用set_dump GUI打开，搜索csm下面video的偏移量，笔者的是0x8CE，并且注意legacy only和UEFI only分别对应的数字如下图，UEFI only 0x1，legacy only 0x2
  
  ![](images/csm.jpg)

* 修改BIOS设置，将csm打开，启动设备控制选择UEFI and Legacy，这样可以保证mbr下的xp系统的启动。并且把第一第二启动项分别设置为OC和xorboot。

* 准备startup.nsh脚本，这个脚本做两件事
  
  * 用setup_var修改csm中的video选项，如
    
    ```
    setup_var.efi -r Setup:0x8CE=0x02
    ```
  
  * 利用重命名efi文件的方法，修改第一启动项为OC或xorboot，完整脚本如下
    
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

* 脚本简单解释
  
  * 搜索存在setup_var.efi的分区并锁定
  
  * 判断当前模式，如果存在OpenCore.efi文件，则说明当前video是UEFI模式，反之则为legacy。
  
  * 基于当前模式执行不同操作
    
    * UEFI：将OpenCore.efi重命名为OpenCore.efi.bak，将xorboot的efi文件名称还原回xorboot.efi，相当于第一启动项改xorboot，用setup_var.efi将video设置成legacy，会自动重启，自然进入legacy模式的xorboot，进而启动xp/vista/7。
    
    * legacy：将OpenCore.efi.bak还原为OpenCore.efi，将xorboot.efi重命名为xorboot.efi.bak，相当于第一启动项改OC，用setup_var.efi将video设置成UEFI，会自动重启，自然进入UEFI模式的OC，进而启动现代系统。

* 将startup.nsh放到EFI分区(和OpenShell.efi文件同分区)根目录，和EFI文件夹同层级

* 在OC的Tools文件夹中加入OpenShell.efi文件并在config中添加此条目，参数为-nointerrupt -noconsolein -noconsoleout
  
  ![](images/OpenCore/OpenShell.jpg)

* 在xorboot中加入OpenShell条目，参数同上
  
  ![](images/xorboot/xorboot1.jpg)

### 至此，已完成自动化设置bios的第一启动项并且控制csm中的video选项，OpenShell.efi会自动运行同分区根目录的startup.nsh脚本。

# 2026.5.31更新
## 老系统浏览器
### Windows
* supermium(Windows XP, 2003, Vista, 7, 8 and 8.1) https://github.com/win32ss/supermium

### Mac OS X/OS X/macOS
* chromium-legacy(Mac OS X 10.7，OS X 10.8-10.11，macOS 10.12-10.14) https://github.com/blueboxd/chromium-legacy

# 2026.6.3更新
## 解锁CFG Lock
> 笔者的主板是ASUS P8Z77M Pro，这款主板无法搜索出CFG Lock的偏移量，所以需要修改BIOS并刷入以解锁CFG Lock，笔者在仓库中提供了解锁后的BIOS，位于bios文件夹中。
### 所需设备
* U盘1个

### 所需工具(位于bios文件夹)
* UEFIPatch
* AMIBCP
* UEFITool

### 修改BIOS(解锁CFG Lock并解锁部分隐藏选项)
> 在Windows11下操作
* 下载官方BIOS文件备用
* 将官方BIOS重命名为bios.CAP并拷贝到UEFIPatch文件夹
![](images/bios/bios1.png)
* 在当前目录打开终端并输入如下命令以解锁CFG Lock，解锁后的文件位于同目录，名为bios.CAP.patched
```
.\UEFIPatch.exe .\bios.CAP
```
![](images/bios/bios2.png)
![](images/bios/bios3.png)
* 将bios.CAP.patched重命名为P8Z77MP_UNLOCK.CAP
* 用AMIBCP打开P8Z77MP_UNLOCK.CAP，将需要解锁的选项(如CSM下的video选项，intel vt-d等)的Access/Use设置为USER并保存
![](images/bios/bios5.png)
![](images/bios/bios4.png)
* 用UEFITool打开处理后的P8Z77MP_UNLOCK.CAP，导航到BIOS region，点击右键，选择Extract as is...，文件名填1，点击保存。得到文件1.rgn
![](images/bios/bios6.png)
![](images/bios/bios7.png)
![](images/bios/bios8.png)
* 用UEFITool打开官网下载的BIOS，导航到BIOS region，点击右键，选择Replace as is...,选择1.rgn，点击打开
![](images/bios/bios9.png)
![](images/bios/bios10.png)
![](images/bios/bios11.png)
* 点击File->Save image file,名称为P8Z77MP.CAP，点击保存
![](images/bios/bios12.png)
![](images/bios/bios13.png)

#### 至此，解锁了CFG Lock、CSM下的video选项以及Intel VT-d的修改版BIOS已制作完成

### 刷写修改版BIOS
* U盘格式化为FAT32格式，分区表类型为MBR，将处理好的P8Z77MP.CAP拷贝到U盘根目录(文件名必须正确)
* 将U盘插入如下USB口(必须是这个口)
![](images/bios/bios14.png)
* 关机，打开机箱侧盖，按住下图中的BIOS_FLBK按键3s，黄灯开始闪烁，等待黄灯熄灭，BIOS刷写成功。
![](images/bios/bios15.png)

### 至此，修改版BIOS已经刷写成功，CFG Lock已经成功解锁，请在OC的config中禁用Kernel->Quirks下的AppleCpuPmCfgLock以及AppleXcpmCfgLock两个选项

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