#!/bin/bash

vol="$(pamixer --get-volume)"
mute="$(pamixer --get-mute)"

# 600 ms — исчезает быстро (поставь 400..900 по вкусу)
timeout_ms=600

if [ "$mute" = "true" ]; then
  # "пустое" уведомление с баром на 0
  dunstify -a volume -t "$timeout_ms" \
    -h string:x-dunst-stack-tag:volume \
    -h int:value:0 \
    " " ""
else
  dunstify -a volume -t "$timeout_ms" \
    -h string:x-dunst-stack-tag:volume \
    -h int:value:"$vol" \
    " " ""
fi

