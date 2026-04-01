#!/usr/bin/env bash
pkill -x gammastep 2>/dev/null || true
nohup gammastep -O 2200 "$@" >/dev/null 2>&1 &
