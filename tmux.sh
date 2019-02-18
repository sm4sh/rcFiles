#!/usr/bin/zsh
BG_GREEN=$'\033[42m'
BLACK=$'\033[0;30m'
NC=$'\033[0m' # No Color

tmux new-session -d 'unbuffer lsyncd ~/.lsyncd | sed -u "s/Normal:.*finished/${BLACK} ${BG_GREEN}&${NC}/i"'
tmux pipe-pane 'cat > /tmp/sync'
tmux split-window -v
tmux send-keys shop Enter
tmux resize-pane -U 1000
tmux new-window 'tail -f /tmp/sync'
tmux split-window -v 'ssh dev' 
tmux send-keys shop Enter
tmux resize-pane -U 1000
tmux previous-window
tmux -2 attach-session -d
