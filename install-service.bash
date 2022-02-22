#!/bin/bash
set -euxo pipefail
cd "$(dirname "$0")"

mkdir -p ~/.config/systemd/user/ && \
which xremap && \
echo "[Unit]
Description=xremap

[Service]
ExecStart=$(which xremap) $(pwd)/config.yml
Restart=always

[Install]
WantedBy=default.target
" > /tmp/xremap.service && \
mv -i /tmp/xremap.service ~/.config/systemd/user/xremap.service

if [ -e ~/.config/systemd/user/xremap.service ]; then
    systemctl --user daemon-reload && \
    systemctl --user enable xremap && \
    systemctl --user start xremap
fi
