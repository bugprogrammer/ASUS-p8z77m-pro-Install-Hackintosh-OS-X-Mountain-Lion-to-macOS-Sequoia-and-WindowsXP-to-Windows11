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
