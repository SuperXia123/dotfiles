# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
#session_root "~/Projects/ndm_envnav"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "ndm_envnav"; then

  new_window "runner"
  run_cmd "cd ~/Tools/bolepack && clear"
  split_h
  select_pane 0
  split_v
  run_cmd "cd ~/Tools/bolepack && clear"

  select_pane 2
  run_cmd "cd ~/Repositories/ndm_envnav/.nvim && clear"
  split_v
  run_cmd "cd ~/Repositories/ndm_envnav/.nvim && clear"

  new_window "nvim"
  run_cmd "cd ~/Repositories/ndm_envnav"
  run_cmd "nvim ."

  new_window "lazygit"
  run_cmd "cd ~/Repositories/ndm_envnav"
  run_cmd "lazygit"

  select_window 0

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
