# mft



### mft RPM包

```bash
[root@ ~]# rpm -qi mft
Name        : mft
Version     : 4.29.0
Release     : 131
Architecture: x86_64
Install Date: Wed 16 Apr 2025 06:43:12 PM CST
Group       : System Environment/Base
Size        : 219531573
License     : Proprietary
Signature   : (none)
Source RPM  : mft-4.29.0-131.src.rpm
Build Date  : Wed 07 Aug 2024 11:33:22 PM CST
Build Host  : mft-build-build-linux-x86-64-2844-n5tf6-vd1kw-6k3zq
Relocations : /usr /etc 
Packager    : Omer Dagan <omerd@mellanox.com>
Vendor      : Mellanox Technologies Ltd.
Summary     : Mellanox firmware tools
```



### mft包中的文件如下：

```bash
[root@ ~]# rpm -ql mft
/etc/init.d/mst
/etc/mft/RPMS/mft
/etc/mft/ca-bundle.crt
/etc/mft/mft.conf
/etc/mft/mst.conf
/usr/bin/dimax_init
/usr/bin/flint
/usr/bin/flint_ext
/usr/bin/fwtrace
/usr/bin/i2c
/usr/bin/mcra
/usr/bin/mdevices_info
/usr/bin/mft-shell
/usr/bin/mft_uninstall.sh
/usr/bin/mget_temp
/usr/bin/mget_temp_ext
/usr/bin/minit
/usr/bin/mlxburn
/usr/bin/mlxburn_old
/usr/bin/mlxcableimgen
/usr/bin/mlxcables
/usr/bin/mlxcables_ext
/usr/bin/mlxconfig
/usr/bin/mlxdpa
/usr/bin/mlxdump
/usr/bin/mlxdump_ext
/usr/bin/mlxfwmanager
/usr/bin/mlxfwreset
/usr/bin/mlxfwstress
/usr/bin/mlxfwstress_ext
/usr/bin/mlxgearbox
/usr/bin/mlxi2c
/usr/bin/mlxlink
/usr/bin/mlxlink_ext
/usr/bin/mlxlink_plane_wrapper
/usr/bin/mlxmcg
/usr/bin/mlxmdio
/usr/bin/mlxpci
/usr/bin/mlxphyburn
/usr/bin/mlxprivhost
/usr/bin/mlxptrace
/usr/bin/mlxptrace_ext
/usr/bin/mlxreg
/usr/bin/mlxreg_ext
/usr/bin/mlxtokengenerator
/usr/bin/mlxtrace
/usr/bin/mlxtrace_ext
/usr/bin/mlxuptime
/usr/bin/mlxvpd
/usr/bin/mremote
/usr/bin/mst
/usr/bin/mst_cable
/usr/bin/mst_ib_add
/usr/bin/mst_retimer
/usr/bin/mst_tool
/usr/bin/mstdump
/usr/bin/mstop
/usr/bin/mtserver
/usr/bin/nvjtag_discovery
/usr/bin/pckt_drop
/usr/bin/resourcedump
/usr/bin/resourceparse
/usr/bin/rm_driver_discovery
/usr/bin/stedump
/usr/bin/sysfs_module_com
/usr/bin/wqdump
/usr/bin/wqdump_ext
/usr/include/mft/cmdif/cib_cif.h
/usr/include/mft/cmdif/icmd_cif_common.h
/usr/include/mft/cmdif/icmd_cif_open.h
/usr/include/mft/cmdif/icmd_ibdump.h
/usr/include/mft/common/bit_slice.h
/usr/include/mft/common/compatibility.h
/usr/include/mft/memaccess/qpcaccess.h
/usr/include/mft/mtcr.h
/usr/include/mft/mtcr/mtcr.h
/usr/include/mft/mtcr/mtcr_com_defs.h
/usr/include/mft/mtcr/mtcr_mf.h
/usr/include/mft/mtcr_com_defs.h
/usr/include/mft/mtcr_mf.h
/usr/include/mft/sdk/mlxreg_sdk.h
/usr/include/mft/sdk/resource_dump_sdk.h
/usr/include/mft/sdk/resource_dump_segments.h
/usr/include/mft/sdk/resource_dump_segments_be.h
/usr/include/mft/sdk/resource_dump_segments_le.h
/usr/include/mft/sdk/resource_dump_types.h
/usr/include/mft/tools_layouts/adb_to_c_utils.h
/usr/include/mft/tools_layouts/ibdump_layouts.h
/usr/lib/.build-id
/usr/lib/.build-id/10
/usr/lib/.build-id/10/c7a8c5696bd094204a596bce50b1ba1fb846cb
/usr/lib/.build-id/17
/usr/lib/.build-id/17/e5390d181fe6e468f9ed9699201f70c27407b9
/usr/lib/.build-id/2b
/usr/lib/.build-id/2b/d7afb01290ed0b87bfc87fddf44c4821a5d5f7
/usr/lib/.build-id/37
/usr/lib/.build-id/37/802ae16e0e758739154cee2da4474e59f250ee
/usr/lib/.build-id/38
/usr/lib/.build-id/38/955bdba698c362b329ef9a3505a37de1c5891f
/usr/lib/.build-id/3d
/usr/lib/.build-id/3d/ad590edfa57b02b37d7f4c195d3aac0ff9bef2
/usr/lib/.build-id/40
/usr/lib/.build-id/40/4ce471959b2d30050f49b1e6a0712487a3e6f6
/usr/lib/.build-id/41
/usr/lib/.build-id/41/3e396cb86f1c6c05632e8500f36121b9d4c2d7
/usr/lib/.build-id/45
/usr/lib/.build-id/45/aad16cafd1805b858ad72409dc5a19422603e7
/usr/lib/.build-id/4d
/usr/lib/.build-id/4d/0b8ce4ff15ab7f6098d2c7bb77ed27dfe0da37
/usr/lib/.build-id/50
/usr/lib/.build-id/50/ea515b16fa001150d6d18e523490d438485179
/usr/lib/.build-id/59
/usr/lib/.build-id/59/9021cbddefbedd0605f83c5160876ff36e68bd
/usr/lib/.build-id/60
/usr/lib/.build-id/60/bd33c18cf048dd89dce4f80a27a4da7904f6df
/usr/lib/.build-id/60/bfe2319a1267622d58682d4f739da72567e8f8
/usr/lib/.build-id/62
/usr/lib/.build-id/62/d259ae75f40e9dcea29bfdb5c9d16ee5c2d42d
/usr/lib/.build-id/7f
/usr/lib/.build-id/7f/844e75a4e47df0e5d2a3d1d785c1b4cec5858c
/usr/lib/.build-id/7f/b0f3b9de9ae80b4e3b747bf04218f5a283c2d6
/usr/lib/.build-id/88
/usr/lib/.build-id/88/b30911c783e409783aa734375752a4262b42f2
/usr/lib/.build-id/8a
/usr/lib/.build-id/8a/c640fcda0b16fa0882902d7e1067ef84df736b
/usr/lib/.build-id/8d
/usr/lib/.build-id/8d/30f6d6cb0ee4aeb75a3cd5817efaf1e2f13fbe
/usr/lib/.build-id/95
/usr/lib/.build-id/95/5c8b07ac8bbea05b5d15319c054cbe13e91c1c
/usr/lib/.build-id/9b
/usr/lib/.build-id/9b/8b11d09d2a20031ae5b1b92af27923dc4e7a2c
/usr/lib/.build-id/a5
/usr/lib/.build-id/a5/a0659d9877a988d8d4d7ecb02a065014489141
/usr/lib/.build-id/b2
/usr/lib/.build-id/b2/aa330176d5f4213a343c50596ad4d9b857a3ae
/usr/lib/.build-id/b4
/usr/lib/.build-id/b4/b8414325620b5d10d28c0aa33aa1d7aa9e3108
/usr/lib/.build-id/ba
/usr/lib/.build-id/ba/2ebc2426fa79b6b628cba960dc17b79b4c8db0
/usr/lib/.build-id/c4
/usr/lib/.build-id/c4/938e49d6e9cc6bcc7a8d76e88b01b418b7c7ea
/usr/lib/.build-id/c9
/usr/lib/.build-id/c9/1faad70834056917b09db0586e5d6dec51c633
/usr/lib/.build-id/d2
/usr/lib/.build-id/d2/b8b7fea3f1304adf3905abf43c77990603ce64
/usr/lib/.build-id/d2/dce8cc89b1e172eb86c061767b3185d58df8b9
/usr/lib/.build-id/d6
/usr/lib/.build-id/d6/ded84f354a283ff6ac5e88b370e89d91f5bf0d
/usr/lib/.build-id/d7
/usr/lib/.build-id/d7/dc0c82d06413e3384c21c24acfd8019bb3fae7
/usr/lib/.build-id/d8
/usr/lib/.build-id/d8/d96c7d3bdc33a688461fd1fad3bb494b49922e
/usr/lib/.build-id/e1
/usr/lib/.build-id/e1/a774003b7b84a4f6cd5f875085096b42a853cb
/usr/lib/.build-id/e2
/usr/lib/.build-id/e2/084afbd805573dfb54d1bbedd591f7862edd4e
/usr/lib/.build-id/ed
/usr/lib/.build-id/ed/6c11be95f60225be14a5d9a4f761665f062d5d
/usr/lib64/mft/bash_libs/tools_version.sh
/usr/lib64/mft/ext_libs/libcrypto.so.3
/usr/lib64/mft/libcmdif_ibdump.a
/usr/lib64/mft/libmemaccess.a
/usr/lib64/mft/libmtcr.a
/usr/lib64/mft/libmtcr_ul.a
/usr/lib64/mft/mtcr_plugins/mcables.so
/usr/lib64/mft/mtcr_plugins/ssh_utility.so
/usr/lib64/mft/python_tools/c_dev_mgt.so
/usr/lib64/mft/python_tools/ccmdif.so
/usr/lib64/mft/python_tools/cmdif.py
/usr/lib64/mft/python_tools/cmtcr.so
/usr/lib64/mft/python_tools/dev_mgt.py
/usr/lib64/mft/python_tools/device_info.so
/usr/lib64/mft/python_tools/device_info_wrapper.py
/usr/lib64/mft/python_tools/fwtrace/fw_trace_utilities.py
/usr/lib64/mft/python_tools/fwtrace/fwparse.py
/usr/lib64/mft/python_tools/fwtrace/fwtrace.py
/usr/lib64/mft/python_tools/fwtrace/secure_fw_trace.py
/usr/lib64/mft/python_tools/gearbox/abir_add_devices.py
/usr/lib64/mft/python_tools/gearbox/add_gearbox_devices.py
/usr/lib64/mft/python_tools/gearbox/amos_add_devices.py
/usr/lib64/mft/python_tools/gearbox/amos_gb_reset_script.py
/usr/lib64/mft/python_tools/gearbox/amos_gb_sw_mux_config.py
/usr/lib64/mft/python_tools/gearbox/buffalo_fui.py
/usr/lib64/mft/python_tools/gearbox/gearbox_lc_control_reset.py
/usr/lib64/mft/python_tools/gearbox/gearbox_remove_script.py
/usr/lib64/mft/python_tools/gearbox/gearbox_status_script.py
/usr/lib64/mft/python_tools/mft_logger.py
/usr/lib64/mft/python_tools/mlxburn/__init__.py
/usr/lib64/mft/python_tools/mlxburn/cli_wrapping_utils.py
/usr/lib64/mft/python_tools/mlxburn/mlxburn.py
/usr/lib64/mft/python_tools/mlxburn/mlxburn_argumentParser.py
/usr/lib64/mft/python_tools/mlxburn/mlxburn_constants.py
/usr/lib64/mft/python_tools/mlxburn/mlxburn_utils.py
/usr/lib64/mft/python_tools/mlxburn/modes/__init__.py
/usr/lib64/mft/python_tools/mlxburn/modes/mlxburn_BurnMode.py
/usr/lib64/mft/python_tools/mlxburn/modes/mlxburn_ImageGenerateMode.py
/usr/lib64/mft/python_tools/mlxburn/modes/mlxburn_QueryMode.py
/usr/lib64/mft/python_tools/mlxburn/modes/mlxburn_ShowVpdMode.py
/usr/lib64/mft/python_tools/mlxburn/modes/mlxburn_ViewVersionMode.py
/usr/lib64/mft/python_tools/mlxburn/modes/mlxburn_mode.py
/usr/lib64/mft/python_tools/mlxfwreset/mlxfwreset.py
/usr/lib64/mft/python_tools/mlxfwreset/mlxfwresetlib/__init__.py
/usr/lib64/mft/python_tools/mlxfwreset/mlxfwresetlib/cmd_reg_mcam.py
/usr/lib64/mft/python_tools/mlxfwreset/mlxfwresetlib/cmd_reg_mfrl.py
/usr/lib64/mft/python_tools/mlxfwreset/mlxfwresetlib/cmd_reg_mpcir.py
/usr/lib64/mft/python_tools/mlxfwreset/mlxfwresetlib/cmd_reg_mrsi.py
/usr/lib64/mft/python_tools/mlxfwreset/mlxfwresetlib/logger.py
/usr/lib64/mft/python_tools/mlxfwreset/mlxfwresetlib/mcra.py
/usr/lib64/mft/python_tools/mlxfwreset/mlxfwresetlib/mlnx_peripheral_components.py
/usr/lib64/mft/python_tools/mlxfwreset/mlxfwresetlib/mlxfwreset_mlnxdriver.py
/usr/lib64/mft/python_tools/mlxfwreset/mlxfwresetlib/mlxfwreset_status_checker.py
/usr/lib64/mft/python_tools/mlxfwreset/mlxfwresetlib/mlxfwreset_utils.py
/usr/lib64/mft/python_tools/mlxfwreset/mlxfwresetlib/pci_device.py
/usr/lib64/mft/python_tools/mlxlink/mlxlink_plane_wrapper.py
/usr/lib64/mft/python_tools/mlxmcg/mlxmcg.py
/usr/lib64/mft/python_tools/mlxpci/binary_file.py
/usr/lib64/mft/python_tools/mlxpci/mlxpci.py
/usr/lib64/mft/python_tools/mlxpci/mlxpci_lib.py
/usr/lib64/mft/python_tools/mlxprivhost/mlxprivhost.py
/usr/lib64/mft/python_tools/mlxste/__init__.py
/usr/lib64/mft/python_tools/mlxste/api.py
/usr/lib64/mft/python_tools/mlxste/argtypes.py
/usr/lib64/mft/python_tools/mlxste/constants.py
/usr/lib64/mft/python_tools/mlxste/crawler.py
/usr/lib64/mft/python_tools/mlxste/dmlib.py
/usr/lib64/mft/python_tools/mlxste/dumpers/__init__.py
/usr/lib64/mft/python_tools/mlxste/dumpers/dumper.py
/usr/lib64/mft/python_tools/mlxste/dumpers/pcap.py
/usr/lib64/mft/python_tools/mlxste/dumpers/raw.py
/usr/lib64/mft/python_tools/mlxste/errors.py
/usr/lib64/mft/python_tools/mlxste/factory.py
/usr/lib64/mft/python_tools/mlxste/loaders/__init__.py
/usr/lib64/mft/python_tools/mlxste/loaders/loader.py
/usr/lib64/mft/python_tools/mlxste/loaders/pcap.py
/usr/lib64/mft/python_tools/mlxste/loaders/raw.py
/usr/lib64/mft/python_tools/mlxste/packet.py
/usr/lib64/mft/python_tools/mlxste/parser.py
/usr/lib64/mft/python_tools/mlxste/providers/__init__.py
/usr/lib64/mft/python_tools/mlxste/providers/provider.py
/usr/lib64/mft/python_tools/mlxste/providers/resourcedump_provider.py
/usr/lib64/mft/python_tools/mlxste/stedump.py
/usr/lib64/mft/python_tools/mlxste/stelib.py
/usr/lib64/mft/python_tools/mlxste/stetypes.py
/usr/lib64/mft/python_tools/mst_cable/mst_cable.py
/usr/lib64/mft/python_tools/mst_ib_add/mst_ib_add.py
/usr/lib64/mft/python_tools/mst_retimer/mst_retimer.py
/usr/lib64/mft/python_tools/mstdump/create_csv2.py
/usr/lib64/mft/python_tools/mstdump/devlink_to_dump.py
/usr/lib64/mft/python_tools/mstdump/mstdump.py
/usr/lib64/mft/python_tools/mtcr.py
/usr/lib64/mft/python_tools/nvjtag/GB100_Jtag.py
/usr/lib64/mft/python_tools/nvjtag/SDDV_Jtag.py
/usr/lib64/mft/python_tools/nvjtag/jtag.py
/usr/lib64/mft/python_tools/regaccess.py
/usr/lib64/mft/python_tools/regaccess_hca_ext_structs.py
/usr/lib64/mft/python_tools/regaccess_switch_ext_structs.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump_lib/__init__.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump_lib/commands/CommandFactory.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump_lib/commands/DumpCommand.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump_lib/commands/QueryCommand.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump_lib/commands/ResDumpCommand.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump_lib/commands/__init__.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump_lib/cresourcedump/CResourceDump.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump_lib/cresourcedump/__init__.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump_lib/cresourcedump/cresourcedump_types.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump_lib/fetchers/CapabilityFetcher.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump_lib/fetchers/__init__.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump_lib/filters/SegmentsFilter.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump_lib/filters/__init__.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump_lib/utils/Exceptions.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump_lib/utils/__init__.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump_lib/utils/constants.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump_lib/validation/CapabilityValidator.py
/usr/lib64/mft/python_tools/resourcetools/resourcedump_lib/validation/__init__.py
/usr/lib64/mft/python_tools/resourcetools/resourceparse.py
/usr/lib64/mft/python_tools/resourcetools/resourceparse_lib/ResourceParseManager.py
/usr/lib64/mft/python_tools/resourcetools/resourceparse_lib/__init__.py
/usr/lib64/mft/python_tools/resourcetools/resourceparse_lib/parsers/AdbParser.py
/usr/lib64/mft/python_tools/resourcetools/resourceparse_lib/parsers/AdbResourceParser.py
/usr/lib64/mft/python_tools/resourcetools/resourceparse_lib/parsers/AddressValueParser.py
/usr/lib64/mft/python_tools/resourcetools/resourceparse_lib/parsers/MenuParser.py
/usr/lib64/mft/python_tools/resourcetools/resourceparse_lib/parsers/RawParser.py
/usr/lib64/mft/python_tools/resourcetools/resourceparse_lib/parsers/ResourceParser.py
/usr/lib64/mft/python_tools/resourcetools/resourceparse_lib/parsers/__init__.py
/usr/lib64/mft/python_tools/resourcetools/resourceparse_lib/resource_data/AdbData.py
/usr/lib64/mft/python_tools/resourcetools/resourceparse_lib/resource_data/DataPrinter.py
/usr/lib64/mft/python_tools/resourcetools/resourceparse_lib/resource_data/RawData.py
/usr/lib64/mft/python_tools/resourcetools/resourceparse_lib/resource_data/__init__.py
/usr/lib64/mft/python_tools/resourcetools/resourceparse_lib/utils/Exceptions.py
/usr/lib64/mft/python_tools/resourcetools/resourceparse_lib/utils/__init__.py
/usr/lib64/mft/python_tools/resourcetools/resourceparse_lib/utils/common_functions.py
/usr/lib64/mft/python_tools/resourcetools/resourceparse_lib/utils/constants.py
/usr/lib64/mft/python_tools/resourcetools/segments/CommandSegment.py
/usr/lib64/mft/python_tools/resourcetools/segments/ErrorSegment.py
/usr/lib64/mft/python_tools/resourcetools/segments/InfoSegment.py
/usr/lib64/mft/python_tools/resourcetools/segments/MenuRecord.py
/usr/lib64/mft/python_tools/resourcetools/segments/MenuSegment.py
/usr/lib64/mft/python_tools/resourcetools/segments/NoticeSegment.py
/usr/lib64/mft/python_tools/resourcetools/segments/RefSegment.py
/usr/lib64/mft/python_tools/resourcetools/segments/ResourceSegment.py
/usr/lib64/mft/python_tools/resourcetools/segments/Segment.py
/usr/lib64/mft/python_tools/resourcetools/segments/SegmentCreator.py
/usr/lib64/mft/python_tools/resourcetools/segments/SegmentFactory.py
/usr/lib64/mft/python_tools/resourcetools/segments/TerminateSegment.py
/usr/lib64/mft/python_tools/resourcetools/segments/__init__.py
/usr/lib64/mft/python_tools/rreg_access.so
/usr/lib64/mft/python_tools/stelib.so
/usr/lib64/mft/python_tools/sysfs_module_com/sysfs_module_com.py
/usr/lib64/mft/python_tools/tools_version.py
/usr/lib64/mft/sdk/libmlxreg_sdk.so
/usr/lib64/mft/sdk/libresource_dump_sdk.so
/usr/lib64/mft/sdk/libresource_dump_sdk_no_ofed.so
/usr/lib64/mft/tcl
/usr/lib64/mft/tcl/bin
/usr/lib64/mft/tcl/bin/tclsh8.6
/usr/lib64/mft/tcl/lib
/usr/lib64/mft/tcl/lib/tcl8.6
/usr/lib64/mft/tcl/lib/tcl8.6/init.tcl
/usr/share/man/man1
/usr/share/man/man1/flint.1.gz
/usr/share/man/man1/fwtrace.1.gz
/usr/share/man/man1/i2c.1.gz
/usr/share/man/man1/mcra.1.gz
/usr/share/man/man1/mdevices_info.1.gz
/usr/share/man/man1/mget_temp.1.gz
/usr/share/man/man1/mic.1.gz
/usr/share/man/man1/minit.1.gz
/usr/share/man/man1/mlxburn.1.gz
/usr/share/man/man1/mlxcables.1.gz
/usr/share/man/man1/mlxconfig.1.gz
/usr/share/man/man1/mlxdump.1.gz
/usr/share/man/man1/mlxfwmanager.1.gz
/usr/share/man/man1/mlxfwreset.1.gz
/usr/share/man/man1/mlxi2c.1.gz
/usr/share/man/man1/mlxlink.1.gz
/usr/share/man/man1/mlxmcg.1.gz
/usr/share/man/man1/mlxmdio.1.gz
/usr/share/man/man1/mlxphyburn.1.gz
/usr/share/man/man1/mlxreg.1.gz
/usr/share/man/man1/mlxtrace.1.gz
/usr/share/man/man1/mlxuptime.1.gz
/usr/share/man/man1/mlxvpd.1.gz
/usr/share/man/man1/mremote.1.gz
/usr/share/man/man1/mst.1.gz
/usr/share/man/man1/mst_ib_add.tcl.1.gz
/usr/share/man/man1/mstdump.1.gz
/usr/share/man/man1/mstop.1.gz
/usr/share/man/man1/mtserver.1.gz
/usr/share/man/man1/pckt_drop.1.gz
/usr/share/man/man1/t2a.1.gz
/usr/share/man/man1/wqdump.1.gz
/usr/share/mft/device_info
/usr/share/mft/device_info/json
/usr/share/mft/device_info/json/0x11.json
/usr/share/mft/device_info/json/0x19.json
/usr/share/mft/device_info/json/0x1e.json
/usr/share/mft/device_info/json/0x1f5.json
/usr/share/mft/device_info/json/0x1f7.json
/usr/share/mft/device_info/json/0x1ff.json
/usr/share/mft/device_info/json/0x209.json
/usr/share/mft/device_info/json/0x20b.json
/usr/share/mft/device_info/json/0x20d.json
/usr/share/mft/device_info/json/0x20f.json
/usr/share/mft/device_info/json/0x211.json
/usr/share/mft/device_info/json/0x212.json
/usr/share/mft/device_info/json/0x214.json
/usr/share/mft/device_info/json/0x216.json
/usr/share/mft/device_info/json/0x218.json
/usr/share/mft/device_info/json/0x21c.json
/usr/share/mft/device_info/json/0x21e.json
/usr/share/mft/device_info/json/0x220.json
/usr/share/mft/device_info/json/0x247.json
/usr/share/mft/device_info/json/0x249.json
/usr/share/mft/device_info/json/0x24b.json
/usr/share/mft/device_info/json/0x24d.json
/usr/share/mft/device_info/json/0x24e.json
/usr/share/mft/device_info/json/0x250.json
/usr/share/mft/device_info/json/0x252.json
/usr/share/mft/device_info/json/0x253.json
/usr/share/mft/device_info/json/0x254.json
/usr/share/mft/device_info/json/0x256.json
/usr/share/mft/device_info/json/0x257.json
/usr/share/mft/device_info/json/0x259.json
/usr/share/mft/device_info/json/0x25b.json
/usr/share/mft/device_info/json/0x270.json
/usr/share/mft/device_info/json/0x274.json
/usr/share/mft/device_info/json/0x278.json
/usr/share/mft/device_info/json/0x282.json
/usr/share/mft/device_info/json/0x2900.json
/usr/share/mft/device_info/json/0x3.json
/usr/share/mft/device_info/json/0x3000.json
/usr/share/mft/device_info/json/0x6b.json
/usr/share/mft/device_info/json/0x6e.json
/usr/share/mft/device_info/json/0x6f.json
/usr/share/mft/device_info/json/0x70.json
/usr/share/mft/device_info/json/0x71.json
/usr/share/mft/device_info/json/0x72.json
/usr/share/mft/device_info/json/0x73.json
/usr/share/mft/device_info/json/0x7e.json
/usr/share/mft/device_info/json/0x7f.json
/usr/share/mft/device_info/json/0x80.json
/usr/share/mft/device_info/json/0x82.json
/usr/share/mft/device_info/json/0xd.json
/usr/share/mft/fw_stress_db
/usr/share/mft/fw_stress_db/stress_types.db
/usr/share/mft/fw_stress_db/stress_types_ext.db
/usr/share/mft/mlxconfig_dbs
/usr/share/mft/mlxconfig_dbs/mlxconfig_host.db
/usr/share/mft/mlxconfig_dbs/mlxconfig_switch.db
/usr/share/mft/mstdump_dbs
/usr/share/mft/mstdump_dbs/AbirGearBox.csv
/usr/share/mft/mstdump_dbs/AmosGearBox.csv
/usr/share/mft/mstdump_dbs/AmosGearBoxManager.csv
/usr/share/mft/mstdump_dbs/ArcusE.csv
/usr/share/mft/mstdump_dbs/ArcusP_TC.csv
/usr/share/mft/mstdump_dbs/BlueField.csv
/usr/share/mft/mstdump_dbs/BlueField2.csv
/usr/share/mft/mstdump_dbs/BlueField2.csv2
/usr/share/mft/mstdump_dbs/BlueField3.csv
/usr/share/mft/mstdump_dbs/Cable.csv
/usr/share/mft/mstdump_dbs/CableCMIS.csv
/usr/share/mft/mstdump_dbs/CableCMISPaging.csv
/usr/share/mft/mstdump_dbs/CableQSFP.csv
/usr/share/mft/mstdump_dbs/CableQSFPaging.csv
/usr/share/mft/mstdump_dbs/CableSFP.csv
/usr/share/mft/mstdump_dbs/CableSFP51.csv
/usr/share/mft/mstdump_dbs/CableSFP51Paging.csv
/usr/share/mft/mstdump_dbs/ConnectIB.csv
/usr/share/mft/mstdump_dbs/ConnectX2.csv
/usr/share/mft/mstdump_dbs/ConnectX3.csv
/usr/share/mft/mstdump_dbs/ConnectX3Pro.csv
/usr/share/mft/mstdump_dbs/ConnectX4.csv
/usr/share/mft/mstdump_dbs/ConnectX4LX.csv
/usr/share/mft/mstdump_dbs/ConnectX5.csv
/usr/share/mft/mstdump_dbs/ConnectX6.csv
/usr/share/mft/mstdump_dbs/ConnectX6.csv2
/usr/share/mft/mstdump_dbs/ConnectX6DX.csv
/usr/share/mft/mstdump_dbs/ConnectX6DX.csv2
/usr/share/mft/mstdump_dbs/ConnectX6LX.csv
/usr/share/mft/mstdump_dbs/ConnectX6LX.csv2
/usr/share/mft/mstdump_dbs/ConnectX7.csv
/usr/share/mft/mstdump_dbs/ConnectX7.csv2
/usr/share/mft/mstdump_dbs/ConnectX8.csv
/usr/share/mft/mstdump_dbs/GB100.csv
/usr/share/mft/mstdump_dbs/GB100_PXUC.csv
/usr/share/mft/mstdump_dbs/InfiniScaleIV.csv
/usr/share/mft/mstdump_dbs/Quantum.csv
/usr/share/mft/mstdump_dbs/Quantum2.csv
/usr/share/mft/mstdump_dbs/Quantum3.csv
/usr/share/mft/mstdump_dbs/Quantum4.csv
/usr/share/mft/mstdump_dbs/Spectrum.csv
/usr/share/mft/mstdump_dbs/Spectrum2.csv
/usr/share/mft/mstdump_dbs/Spectrum3.csv
/usr/share/mft/mstdump_dbs/Spectrum4.csv
/usr/share/mft/mstdump_dbs/Spectrum5.csv
/usr/share/mft/mstdump_dbs/SwitchIB.csv
/usr/share/mft/mstdump_dbs/SwitchIB2.csv
/usr/share/mft/mstdump_dbs/SwitchX.csv
/usr/share/mft/prm_dbs
/usr/share/mft/prm_dbs/gpu
/usr/share/mft/prm_dbs/gpu/ext
/usr/share/mft/prm_dbs/gpu/ext/register_access_table.adb
/usr/share/mft/prm_dbs/gpu/ext/register_access_table.dat
/usr/share/mft/prm_dbs/hca
/usr/share/mft/prm_dbs/hca/ext
/usr/share/mft/prm_dbs/hca/ext/register_access_table.adb
/usr/share/mft/prm_dbs/hca/ext/register_access_table.dat
/usr/share/mft/prm_dbs/retimers
/usr/share/mft/prm_dbs/retimers/ext
/usr/share/mft/prm_dbs/retimers/ext/register_access_table.adb
/usr/share/mft/prm_dbs/retimers/ext/register_access_table.dat
/usr/share/mft/prm_dbs/switch
/usr/share/mft/prm_dbs/switch/ext
/usr/share/mft/prm_dbs/switch/ext/register_access_table.adb
/usr/share/mft/prm_dbs/switch/ext/register_access_table.dat
/usr/share/mft/remote
/usr/share/mft/remote/remote.json
```



### **MFT (Mellanox Firmware Tools)**

#### **1基本功能**

- 用于管理 **Mellanox 网络设备**（如InfiniBand、以太网适配器、交换机）的固件和硬件配置。
- 提供命令行工具和实用程序，支持固件升级、设备监控、调试和性能调优。

#### **2主要组件**

- **固件管理**：升级/降级网卡（如ConnectX系列）或交换机的固件。
- **设备配置**：修改硬件参数（如链路速度、PCIe设置）。
- **诊断工具**：收集日志、运行硬件测试（如 `mlxfwmanager`、`mstflint`）。
- **监控**：实时查看设备状态（如温度、端口统计）。

#### **3.版本信息**

- 你安装的版本是 **4.29.0**，发布于 **2024年8月7日**，适用于 **x86_64** 架构。
- 许可证为 **Proprietary**（专有软件），由 Mellanox/NVIDIA 维护。

#### **4.典型使用场景**

- 在 **高性能计算（HPC）**、**数据中心** 或 **云环境** 中管理 Mellanox 设备。

- 例如：

  ```bash
  mlxfwmanager
  ```

#### **5.相关命令和路径**

- 工具通常安装在 `/usr/bin` 或 `/opt/mellanox/mft` 下。
- 常用命令包括 `mst`、`mlxconfig`、`mlxlink` 等。

#### **6.注意事项**

- 需要 **root权限** 运行大多数操作。
- 部分功能可能依赖 Mellanox 硬件驱动（如 `mlx5_core`）。





### mlxconfig 命令

```bash
[root@ ~]# mlxconfig --help 
名称:
    mlxconfig
概要:
    mlxconfig [选项] <命令> [参数]
描述:
    允许用户在不创建并烧录新固件的情况下更改设备配置。

选项:
    -d|--dev <device>               : 针对指定的 MST 设备执行操作。
    -b|--db <filename>              : 使用特定的数据库文件。
    -f|--file <conf_file>           : 原始配置文件。
    -h|--help                       : 显示帮助信息。
    -v|--version                    : 显示版本信息。
    -e|--enable_verbosity           : 显示默认和当前配置。
    -y|--yes                        : 在提示中自动回答“是”。
    -a|--all_attrs                  : 显示 XML 模板中的所有属性。
    -p|--private_key <PKEY>         : 私钥的 PEM 文件。
    -u|--key_uuid <UUID>            : 密钥对的 UUID。
    -eng|--openssl_engine <ENGINE>  : OpenSSL 引擎名称。
    -k|--openssl_key_id <IDENTIFIER>: OpenSSL 密钥标识符。
    -|--aws_hsm                     : 在 3S 环境中进行签名。
    -l|--private_key_label          : 用于 3S HSM 签名的私钥标签。
    -t|--device_type <switch/hca>   : 指定设备类型。
    -s|--session_id                 : 指定令牌保持会话的会话 ID。
    -st|--session_time              : 指定令牌保持会话的持续时间。
    -tkn|--token_type               : 指定令牌类型。
    -|--sign_algorithm              : 指定签名算法（可选：RSA4k、RSA3k 或 ECDSA256）。
    -|--nested_token                : 包含 ArcusE 的挑战响应。

命令摘要:
    clear_semaphore          : 清除工具信号量。
    i|show_confs             : 显示所有配置的信息。
    q|query                  : 查询支持的配置。
    r|reset                  : 将所有配置重置为默认值。
    s|set                    : 为指定设备设置配置项。
    set_raw                  : 设置原始配置文件（5 代及以上）。
    get_raw                  : 获取原始配置（5 代及以上）。
    backup                   : 备份配置到文件。使用 set_raw 恢复（5 代及以上）。
    gen_tlvs_file            : 生成所有 TLV 列表。需指定输出文件名。(*)
    g <en_xml_template>      : 生成 XML 模板。需指定 TLV 输入文件和 XML 输出文件。(*)
    xml2raw                  : 从 XML 文件生成原始文件。需指定 XML 输入和原始输出文件。(*)
    raw2xml                  : 从原始文件生成 XML。需指定原始输入和 XML 输出文件。(*)
    xml2bin                  : 从 XML 文件生成二进制配置转储文件。需指定 XML 输入和 bin 输出文件。(*)
    create_conf              : 从 XML 文件生成配置文件。需指定 XML 输入和 bin 输出文件。(*)
    apply                    : 应用使用 create_conf 创建的配置文件。需指定 bin 输入文件。(*)
    challenge_request        : 向设备发送令牌挑战请求。需指定令牌类型。
    remote_token_keep_alive  : 启动远程令牌会话，需指定会话 ID 和时间。
    token_supported          : 查询支持的令牌类型。
    query_token_session      : 查询令牌会话状态。
    end_token_session        : 结束活动的令牌会话。

(*) 这些命令不需要 MST 设备

要按设备类型查看支持的配置，请运行 show_confs 命令

示例:
    要查询配置      : mlxconfig -d /dev/mst/mt4099_pciconf0 query
    要设置配置      : mlxconfig -d /dev/mst/mt4099_pciconf0 set SRIOV_EN=1 NUM_OF_VFS=16 WOL_MAGIC_EN_P1=1
    要设置原始配置  : mlxconfig -d /dev/mst/mt4115_pciconf0 -f conf_file set_raw
    要重置配置      : mlxconfig -d /dev/mst/mt4099_pciconf0 reset
    要生成 tlvs 文件: mlxconfig -t HCA gen_tlvs_file /tmp/tlvs.txt
    要生成 XML 模板 : mlxconfig -t HCA gen_xml_template /tmp/tlvs.txt /tmp/template.xml
    要从 XML 创建签名二进制: mlxconfig -t HCA -p /tmp/private_key.pem -u 10e651da23d4808c7bc1354bc341220a create_conf /tmp/template.xml /tmp/conf.bin
    要应用配置      : mlxconfig -d /dev/mst/mt4129_pciconf0 apply /tmp/conf.bin
```



### mlxfwmanager 命令



```bash
[root@ ~]#mlxfwmanager --help
名称:
    mlxfwmanager

概要:
    mlxfwmanager
        [-d|--dev 设备名] [-h|--help] [-v|--version] [--query] [--query-format 格式]
        [-u|--update] [-i|--image-file 文件名] [-D|--image-dir 目录名] [-f|--force]
        [--no_fw_ctrl] [-y|--yes] [--no] [--clear-semaphore] [--exe-rel-path]
        [-l|--list-content] [--archive-names] [--nofs] [--log] [-L|--log-file 日志文件名]
        [--no-progress] [-o|--outfile 输出文件名] [--online] [--online-query-psid PSID列表]
        [--key 密钥] [--download 目录名] [--download-default] [--get-download-opt 选项]
        [--download-device 设备] [--download-os 操作系统] [--download-type 类型]
        [--ssl-certificate 证书]

描述:
    Mellanox 固件管理工具

选项:
    -d|--dev 设备名
        : 针对指定的 MST 设备执行操作。使用 `mst status` 列出可用设备。可用分号分隔多个设备。如设备列表中包含分号，请用引号括起来。
    -h|--help
        : 显示帮助信息并退出。
    -v|--version
        : 显示可执行文件版本并退出。
    --query
        : 查询设备信息。
    --query-format 格式
        : 指定查询或在线查询的输出格式，可选 “XML” 或 “Text”（默认 Text）。
    -u|--update
        : 更新设备上的固件映像。
    -i|--image-file 文件名
        : 指定要使用的固件映像文件。
    -D|--image-dir 目录名
        : 指定查找映像文件的目录（替代默认目录）。
    -f|--force
        : 强制映像更新。
    --no_fw_ctrl
        : 不使用 FW 控制器执行更新。
    -y|--yes
        : 在提示时自动回答“是”。
    --no
        : 在提示时自动回答“否”。
    --clear-semaphore
        : 强制清除设备上的闪存信号量。使用此标志时不允许执行其他命令。注意：如果设备或其他应用正在使用闪存，可能导致系统不稳定或闪存损坏，请谨慎操作。
    --exe-rel-path
        : 使用相对于可执行文件所在位置的路径。
    -l|--list-content
        : 列出文件/目录内容（与 `--image-dir` 或 `--image-file` 一起使用）。
    --archive-names
        : 在列出时显示归档名称。
    --nofs
        : 以非容错方式烧录映像。
    --log
        : 生成日志文件。
    -L|--log-file 日志文件名
        : 使用指定的日志文件。
    --no-progress
        : 不显示进度条。
    -o|--outfile 输出文件名
        : 将输出写入指定文件。
    --online
        : 从 Mellanox 服务器在线获取所需固件映像。
    --online-query-psid PSID列表
        : 查询固件信息，PSID 可用逗号分隔。
    --key 密钥
        : 指定自定义下载/更新所用密钥。
    --download 目录名
        : 从服务器下载文件到指定目录。
    --download-default
        : 使用默认值进行下载。
    --get-download-opt 选项
        : 获取下载选项，可选 “OS” 或 “Device”。
    --download-device 设备
        : 与 `--get-download-opt Device` 一起使用，可查看设备特定下载的可用设备列表。
    --download-os 操作系统
        : （仅针对自解压下载）与 `--get-download-opt OS` 一起使用，可查看可用操作系统列表。
    --download-type 类型
        : 指定下载类型，可选 “MFA” 或 “self_extractor”（默认 All）。
    --ssl-certificate 证书
        : 用于安全连接的 SSL 证书。

示例:
    1. 查询特定设备或所有设备（如未指定设备）
       >> mlxfwmanager [-d <设备>] [--query]
    2. 使用指定映像/自解压文件或映像目录烧录设备
       >> mlxfwmanager -d <设备> [-i <映像文件/MFA 文件> | -D <映像目录>]
    3. 更新网卡固件
       >> mlxfwmanager -u
    4. 从网络获取最新固件并更新
       >> mlxfwmanager --online -u
    5. 从网络下载最新固件包
       >> mlxfwmanager --download-default --download-os Linux_x64 --download-type self_extractor
```





```bash
[root@~]# mlxfwmanager --query
正在查询 Mellanox 设备的固件 ...

设备 #1：
----------

  设备类型：      BlueField3
  零件编号：      900-9D3B6-00SC-EA0_Ax
  描述：          NVIDIA BlueField-3 B3210E E 系列 FHHL DPU；100GbE（默认模式）/ HDR100 IB；双端口 QSFP112；PCIe Gen5.0 x16（带 x16 PCIe 扩展选项）；16 核 Arm；32GB 板载 DDR；集成 BMC；加密已禁用
  PSID：          MT_0000001117
  PCI 设备名称：  /dev/mst/mt41692_pciconf0
  基础 MAC：      b8e9248462ae
  版本：          当前           可用   
     FW           32.40.1602     N/A     
     FW（运行中）  32.40.1000     N/A     
     PXE          3.7.0300       N/A     
     UEFI         14.33.0010     N/A     
     UEFI Virtio 块 22.4.0012      N/A     
     UEFI Virtio 网 21.4.0013      N/A     

  状态：          未找到匹配的映像

```





```bash
[root@~]# mlxfwmanager --query
正在查询 Mellanox 设备固件 ...

设备 #1：
----------

  设备类型：      BlueField3  
  零件编号：      900-9D3B6-00SC-EA0_Ax  
  描述：          NVIDIA BlueField-3 B3210E E 系列 FHHL DPU；100GbE（默认模式）/ HDR100 IB；双端口 QSFP112；PCIe Gen5.0 x16（带 x16 PCIe 扩展选项）；16 核 Arm；32GB 板载 DDR；集成 BMC；加密已禁用  
  PSID：          MT_0000001117  
  PCI 设备名称：  0000:43:00.0  
  基础 MAC：      b8e9248462ae  
  版本：          当前           可用     
     FW           32.40.1602     N/A           
     FW（运行中）  32.40.1000     N/A           
     PXE          3.7.0300       N/A           
     UEFI         14.33.0010     N/A           
     UEFI Virtio 块 22.4.0012    N/A           
     UEFI Virtio 网 21.4.0013    N/A           

  状态：          未找到匹配的映像

设备 #2：
----------

  设备类型：      ConnectX7  
  零件编号：      MCX75310AAS-NEA_Ax  
  描述：          NVIDIA ConnectX-7 HHHL 适配卡；400GbE / NDR IB（默认模式）；单端口 OSFP；PCIe 5.0 x16；加密已禁用；已启用安全启动  
  PSID：          MT_0000000838  
  PCI 设备名称：  0000:66:00.0  
  基础 MAC：      b8e924b21eb6  
  版本：          当前           可用     
     FW           28.39.1002     N/A           
     PXE          3.7.0201       N/A           
     UEFI         14.32.0012     N/A           

  状态：          未找到匹配的映像

设备 #3：
----------

  设备类型：      ConnectX7  
  零件编号：      MCX75310AAS-NEA_Ax  
  描述：          NVIDIA ConnectX-7 HHHL 适配卡；400GbE / NDR IB（默认模式）；单端口 OSFP；PCIe 5.0 x16；加密已禁用；已启用安全启动  
  PSID：          MT_0000000838  
  PCI 设备名称：  0000:06:00.0  
  基础 MAC：      b8e924b22216  
  版本：          当前           可用     
     FW           28.39.1002     N/A           
     PXE          3.7.0201       N/A           
     UEFI         14.32.0012     N/A           

  状态：          未找到匹配的映像

设备 #4：
----------

  设备类型：      ConnectX7  
  零件编号：      MCX75310AAS-NEA_Ax  
  描述：          NVIDIA ConnectX-7 HHHL 适配卡；400GbE / NDR IB（默认模式）；单端口 OSFP；PCIe 5.0 x16；加密已禁用；已启用安全启动  
  PSID：          MT_0000000838  
  PCI 设备名称：  0000:86:00.0  
  基础 MAC：      b8e924b220b6  
  版本：          当前           可用     
     FW           28.39.1002     N/A           
     PXE          3.7.0201       N/A           
     UEFI         14.32.0012     N/A           

  状态：          未找到匹配的映像

设备 #5：
----------

  设备类型：      ConnectX7  
  零件编号：      MCX75310AAS-NEA_Ax  
  描述：          NVIDIA ConnectX-7 HHHL 适配卡；400GbE / NDR IB（默认模式）；单端口 OSFP；PCIe 5.0 x16；加密已禁用；已启用安全启动  
  PSID：          MT_0000000838  
  PCI 设备名称：  0000:a6:00.0  
  基础 MAC：      b8e924b218f6  
  版本：          当前           可用     
     FW           28.39.1002     N/A           
     PXE          3.7.0201       N/A           
     UEFI         14.32.0012     N/A           

  状态：          未找到匹配的映像

```

