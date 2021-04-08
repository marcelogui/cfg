#!/bin/bash

ws_focused=$(i3-msg -t get_workspaces | jq -r ".[] | select(.focused==true) | [.name, .output]")

ws_visible=$(i3-msg -t get_workspaces | jq -r ".[] | select(.visible==true) | select(.focused==false) | [.name, .output]")

ws1=$(echo $ws_focused | jq -r ".[0]" | sed 's/[^0-9]//g')
d1=$(echo $ws_focused | jq -r ".[1]")

ws2=$(echo $ws_visible | jq -r ".[0]" | sed 's/[^0-9]//g')
d2=$(echo $ws_visible | jq -r ".[1]")

echo $ws1
echo $ws2

#i3-msg -- [workspace=$ws1] --no-auto-back-and-forth
i3-msg -- move workspace to output $d2
i3-msg -- [workspace=$ws2] focus
#i3-msg -- [workspace=$ws2] --no-auto-back-and-forth
i3-msg -- move workspace to output $d1
i3-msg -- [workspace=$ws2] focus

