/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLxXYVXz.aml, Sat May 23 16:37:00 2026
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000221 (545)
 *     Revision         0x02
 *     Checksum         0xC3
 *     OEM ID           "HACK"
 *     OEM Table ID     "WIFISEL"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200925 (538970405)
 */
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
                     0x03                                             // .
                })
            }

            If (_OSI ("Darw12"))
            {
                Return (Package (0x0C)
                {
                    "device-id", 
                    Buffer (0x04)
                    {
                         0xFF, 0xFF, 0x00, 0x00                           // ....
                    }, 

                    "vendor-id", 
                    Buffer (0x04)
                    {
                         0xFF, 0xFF, 0x00, 0x00                           // ....
                    }, 

                    "class-code", 
                    Buffer (0x04)
                    {
                         0xFF, 0xFF, 0xFF, 0xFF                           // ....
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
                     0x03                                             // .
                })
            }

            If (_OSI ("Darwin"))
            {
                Return (Package (0x0C)
                {
                    "device-id", 
                    Buffer (0x04)
                    {
                         0xFF, 0xFF, 0x00, 0x00                           // ....
                    }, 

                    "vendor-id", 
                    Buffer (0x04)
                    {
                         0xFF, 0xFF, 0x00, 0x00                           // ....
                    }, 

                    "class-code", 
                    Buffer (0x04)
                    {
                         0xFF, 0xFF, 0xFF, 0xFF                           // ....
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
