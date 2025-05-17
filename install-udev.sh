sudo tee /etc/udev/rules.d/99-usb-sync.rules > /dev/null << 'EOF'
ACTION=="add", KERNEL=="sde1", RUN+="/usr/local/bin/usb-sync.sh"
EOF

sudo udevadm control --reload-rules