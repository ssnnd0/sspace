cd ~
tigervncserver -kill
tigervncserver
export DISPLAY=:1
./noVNC/utils/novnc_proxy --vnc localhost:5901
