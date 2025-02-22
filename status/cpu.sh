PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


show_cpu() {
  local index=$1
  local icon=$(get_tmux_option "@gruvbox_cpu_icon" "󰧑")
  local color="$(get_tmux_option "@gruvbox_cpu_color" "#${thm_yellow}")"
  local text="#(${PLUGIN_DIR}/../scripts/get_cpu_percentage.sh)"

  local module=$(build_status_module "$index" "$icon" "$color" "$text")

  echo "$module"
}
