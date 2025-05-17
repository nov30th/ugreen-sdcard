# 🔄 UGREEN SD卡自动同步工具 | UGREEN SD Card Auto-Sync Tool

<div align="center">

![UGREEN](https://img.shields.io/badge/UGREEN-3CB371?style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0IiBmaWxsPSJub25lIiBzdHJva2U9IiNmZmZmZmYiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIj48cGF0aCBkPSJNMTIgMmE2IDYgMCAwIDAgNiA2djEyYTYgNiAwIDAgMS0xMiAwVjhhNiA2IDAgMCAwIDYtNnoiLz48L3N2Zz4=)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat-square&logo=linux&logoColor=black)
![SD Card](https://img.shields.io/badge/SD_Card-FFD700?style=flat-square&logo=sdcard&logoColor=black)

</div>

## 📝 描述 | Description

**中文**：
这是一个适用于绿联(UGREEN)SD卡的自动同步工具，当SD卡插入电脑时，自动将其中的DCIM目录内容同步到指定目录，并发出提示音通知用户同步开始和完成。同步后，原始文件会被删除以释放SD卡空间。

**English**：
This is an automatic synchronization tool for UGREEN SD cards. When an SD card is inserted into the computer, it automatically synchronizes the contents of the DCIM directory to a specified location and plays notification sounds to inform the user when synchronization starts and completes. After synchronization, the original files are deleted to free up space on the SD card.

## ✨ 功能 | Features

**中文**：
- 🔄 自动检测SD卡插入并开始同步
- 🔊 使用蜂鸣器提供声音反馈
- 🔒 使用锁文件防止多个同步进程同时运行
- 📝 详细的日志记录
- 🗑️ 自动删除已同步的源文件
- 🛡️ 错误处理和安全检查

**English**：
- 🔄 Automatically detects SD card insertion and starts synchronization
- 🔊 Provides audio feedback using beeper
- 🔒 Uses lock files to prevent multiple sync processes from running simultaneously
- 📝 Detailed logging
- 🗑️ Automatically deletes source files after synchronization
- 🛡️ Error handling and safety checks

## 🛠️ 安装 | Installation

**中文**：

```bash
# 克隆仓库
git clone https://github.com/yourusername/ugreen-sd-sync.git
cd ugreen-sd-sync

# 安装依赖（如果需要）
sudo apt-get install rsync beep

# 运行安装脚本
chmod +x install-udev.sh install-usb-sync.sh
./install-udev.sh
./install-usb-sync.sh
```

**English**：

```bash
# Clone repository
git clone https://github.com/yourusername/ugreen-sd-sync.git
cd ugreen-sd-sync

# Install dependencies (if needed)
sudo apt-get install rsync beep

# Run installation scripts
chmod +x install-udev.sh install-usb-sync.sh
./install-udev.sh
./install-usb-sync.sh
```

## 🔧 配置 | Configuration

**中文**：

你可以通过编辑 `/usr/local/bin/usb-sync.sh` 文件来修改以下配置：

- `SOURCE_DIR`：SD卡中DCIM目录的路径（默认为 `/mnt/@usb/sde1/DCIM`）
- `TARGET_DIR`：同步目标目录（默认为 `/volume1/hoho`）
- `LOG_FILE`：日志文件位置（默认为 `/var/log/usb-sync.log`）

如果你的SD卡挂载点与 `sde1` 不同，请编辑 `/etc/udev/rules.d/99-usb-sync.rules` 文件。

**English**：

You can modify the following configurations by editing the `/usr/local/bin/usb-sync.sh` file:

- `SOURCE_DIR`: Path to the DCIM directory on the SD card (default is `/mnt/@usb/sde1/DCIM`)
- `TARGET_DIR`: Synchronization target directory (default is `/volume1/hoho`)
- `LOG_FILE`: Log file location (default is `/var/log/usb-sync.log`)

If your SD card mount point is different from `sde1`, please edit the `/etc/udev/rules.d/99-usb-sync.rules` file.

## 📋 工作原理 | How It Works

**中文**：

1. 通过udev规则检测SD卡插入事件
2. 检查SD卡中是否存在DCIM目录并包含文件
3. 发出同步开始的提示音
4. 使用rsync将文件同步到目标目录
5. 删除已同步的源文件
6. 发出同步完成的提示音
7. 记录整个过程的日志

**English**：

1. Detects SD card insertion events through udev rules
2. Checks if the DCIM directory exists on the SD card and contains files
3. Plays a notification sound to indicate the start of synchronization
4. Uses rsync to synchronize files to the target directory
5. Deletes the source files after synchronization
6. Plays a notification sound to indicate completion
7. Logs the entire process

## 📊 日志 | Logs

**中文**：

同步过程的详细日志保存在 `/var/log/usb-sync.log` 文件中。您可以使用以下命令查看日志：

```bash
sudo cat /var/log/usb-sync.log
```

**English**：

Detailed logs of the synchronization process are saved in the `/var/log/usb-sync.log` file. You can view the logs using the following command:

```bash
sudo cat /var/log/usb-sync.log
```

## ⚠️ 故障排除 | Troubleshooting

**中文**：

如果同步不工作：

1. 检查SD卡是否被正确挂载为 `/mnt/@usb/sde1`
2. 确保DCIM目录存在并包含文件
3. 查看日志文件以获取详细错误信息
4. 确保你有足够的权限运行该脚本

**English**：

If synchronization is not working:

1. Check if the SD card is correctly mounted as `/mnt/@usb/sde1`
2. Ensure the DCIM directory exists and contains files
3. Check the log file for detailed error information
4. Make sure you have sufficient permissions to run the script

## 📜 许可证 | License

**中文**：
本项目采用 MIT 许可证。详情请参阅 [LICENSE](LICENSE) 文件。

**English**：
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 🙏 鸣谢 | Acknowledgments

**中文**：
- 感谢绿联(UGREEN)提供的优质SD卡设备
- 感谢所有开源工具的开发者，特别是rsync和beep

**English**：
- Thanks to UGREEN for providing quality SD card devices
- Thanks to all the developers of open-source tools, especially rsync and beep

---

<div align="center">
⭐ 如果你觉得这个工具有用，请给它点个星！| If you find this tool useful, please give it a star! ⭐
</div>