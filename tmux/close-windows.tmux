#!/bin/bash

move-window -t 0 -k
send-keys 'for win in $(tmux list-windows | grep -v ^0); do
  tmux kill-window
done'
