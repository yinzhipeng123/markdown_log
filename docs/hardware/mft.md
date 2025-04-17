# mft



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





```bash
[root@barenode2068-zwlt ~]# rpm -ql mft
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





```
[root@ ~]# mlxconfig --help 
    NAME:
        mlxconfig
    SYNOPSIS:
        mlxconfig [Options] <Commands> [Parameters]
    DESCRIPTION:
        Allows the user to change some of the device configurations without having to
        create and burn a new firmware.
    OPTIONS:
        -d|--dev <device>		: Perform operation for a specified MST device.
        -b|--db <filename>		: Use a specific database file.
        -f|--file <conf_file>		: raw configuration file.
        -h|--help       		: Display help message.
        -v|--version    		: Display version info.
        -e|--enable_verbosity		: Show default and current configurations.
        -y|--yes        		: Answer yes in prompt.
        -a|--all_attrs  		: Show all attributes in the XML template
        -p|--private_key <PKEY>		: pem file for private key
        -u|--key_uuid <UUID>		: keypair uuid
        -eng|--openssl_engine <ENGINE NAME>		: OpenSSL engine name
        -k|--openssl_key_id <IDENTIFIER>		: OpenSSL key identifier
        -|--aws_hsm     		: Sign in 3S environment.
        -l|--private_key_label		: Private key label to use for 3S HSM sign.
        -t|--device_type <switch/hca>		: Specify the device type
        -s|--session_id 		: Specify the session id for token keep alive session.
        -st|--session_time		: Specify session time for token keep alive session.
        -tkn|--token_type		: Specify token type.
        -|--sign_algorithm		: Specify a signature algorithm from the following: RSA4k, RSA3k or ECDSA256.
        -|--nested_token		: Include challenge response for ArcusE.

    COMMANDS SUMMARY
        clear_semaphore          : clear the tool semaphore.
        i|show_confs             : display informations about all configurations.
        q|query                  : query supported configurations.
        r|reset                  : reset all configurations to their default value.
        s|set                    : set configurations to a specific device.
        set_raw                  : set raw configuration file(5th Generation and above).
        get_raw                  : get raw configuration (5th Generation and above).
        backup                   : backup configurations to a file. Use set_raw command to restore file (5th Generation and above).
        gen_tlvs_file            : Generate List of all TLVs. TLVs output file name must be specified. (*)
        g <en_xml_template>      : Generate XML template. TLVs input file name and XML output file name must be specified. (*)
        xml2raw                  : Generate Raw file from XML file. XML input file name and raw output file name must be specified. (*)
        raw2xml                  : Generate XML file from Raw file. raw input file name and XML output file name must be specified. (*)
        xml2bin                  : Generate binary configuration dump file from XML file. XML input file name and bin output file name must be specified. (*)
        create_conf              : Generate configuration file from XML file. XML input file name and bin output file name must be specified. (*)
        apply                    : Apply a configuration file, that was created with create_conf command. bin input file name must be specified. (*)
        challenge_request        : Send a token challenge request to the device. Token type must be specified.
        remote_token_keep_alive  : Start a remote token session for a specified time. session id must be specified.
        token_supported          : Query which tokens are supported.
        query_token_session      : Query the status of a token session.
        end_token_session        : End an active token session.

    (*) These commands do not require MST device

    To show supported configurations by device type, run show_confs command


    Examples:
        To query configurations            : mlxconfig -d /dev/mst/mt4099_pciconf0 query
        To set configuration               : mlxconfig -d /dev/mst/mt4099_pciconf0 set SRIOV_EN=1 NUM_OF_VFS=16 WOL_MAGIC_EN_P1=1
        To set raw configuration           : mlxconfig -d /dev/mst/mt4115_pciconf0 -f conf_file set_raw
        To reset configuration             : mlxconfig -d /dev/mst/mt4099_pciconf0 reset
        To generate tlvs file              : mlxconfig -t HCA gen_tlvs_file /tmp/tlvs.txt
        To generate xml from tlvs file     : mlxconfig -t HCA gen_xml_template /tmp/tlvs.txt /tmp/template.xml
        To create signed binary from xml   : mlxconfig -t HCA -p /tmp/private_key.pem -u 10e651da23d4808c7bc1354bc341220a create_conf /tmp/template.xml /tmp/conf.bin
        To apply configuration to a device : mlxconfig -d /dev/mst/mt4129_pciconf0 apply /tmp/conf.bin
```

