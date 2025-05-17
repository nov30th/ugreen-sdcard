sudo tee /usr/local/bin/usb-sync.sh > /dev/null << 'EOF'
#!/bin/bash

SOURCE_DIR="/mnt/@usb/sde1/DCIM"
TARGET_DIR="/volume1/hoho"
LOG_FILE="/var/log/usb-sync.log"
LOCK_FILE="/tmp/usb-sync.lock"

# 记录日志
log() {
    echo "$(date): $1" >> $LOG_FILE
    echo "$(date): $1"
}

# 检查锁文件，确保同一时间只有一个同步进程在运行
if [ -f "$LOCK_FILE" ]; then
    PID=$(cat "$LOCK_FILE")
    if ps -p $PID > /dev/null; then
        log "另一个同步进程正在运行 (PID: $PID)，跳过本次同步"
        exit 0
    fi
fi

# 创建锁文件
echo $$ > "$LOCK_FILE"

# 确保脚本退出时删除锁文件
trap 'rm -f "$LOCK_FILE"; log "同步进程结束"' EXIT

log "检测到USB设备sde1，准备同步"

# 等待几秒确保挂载完成
sleep 5

# 检查指定的DCIM目录是否存在
if [ ! -d "$SOURCE_DIR" ]; then
    log "未找到DCIM目录: $SOURCE_DIR，跳过同步"
    exit 0
fi

# 检查DCIM目录中是否有文件
FILE_COUNT=$(find "$SOURCE_DIR" -type f | wc -l)
if [ "$FILE_COUNT" -eq 0 ]; then
    log "DCIM目录为空，跳过同步"
    exit 0
fi

log "DCIM目录中有 $FILE_COUNT 个文件，开始同步..."

# 播放提示音
chmod a+rw /dev/input/event3
beep -e /dev/input/event3 \
  -f 1500 -l 100 -D 50 \
  -n -f 1500 -l 100 -D 50 \
  -n -f 2000 -l 300

# 创建目标目录（如果不存在）
mkdir -p "$TARGET_DIR"

# 使用rsync同步文件并删除源文件
rsync -av --remove-source-files "$SOURCE_DIR/" "$TARGET_DIR/" || {
    log "同步发生错误: $?"
    exit 1
}

# 删除空目录
find "$SOURCE_DIR" -type d -empty -delete

log "同步完成，原始文件已删除"

# 播放提示音
beep -e /dev/input/event3 \
  -f 1500 -l 200 -D 50 \
  -n -f 2000 -l 200 -D 50 \
  -n -f 1500 -l 200 -D 50 \
  -n -f 2000 -l 200 -D 500 \
  -n -f 1500 -l 200 -D 50 \
  -n -f 2000 -l 200 -D 50 \
  -n -f 1500 -l 200 -D 50 \
  -n -f 2000 -l 200
EOF

sudo chmod +x /usr/local/bin/usb-sync.sh