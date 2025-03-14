#!/bin/bash

pid=pgrep dwm-sbd.py
[ "$pid" ] && kill pid
dwm-sbd.py
