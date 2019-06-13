#!/usr/bin/zsh
BG_GREEN=$'\033[42m'
BLACK=$'\033[0;30m'
NC=$'\033[0m' # No Color

tmux new-session -d
tmux send-keys 'lsyncd ~/.lsyncd' Enter
tmux pipe-pane 'cat > /tmp/sync'
tmux split-window -v
tmux send-keys shop Enter
tmux resize-pane -U 1000
tmux resize-pane -D 1
tmux new-window 'tail -f /tmp/sync'
tmux split-window -v 
tmux send-keys shop Enter
tmux send-keys 'vagrant up && vagrant ssh' Enter
tmux resize-pane -U 1000
tmux resize-pane -D 1
tmux previous-window
tmux -2 attach-session -d
