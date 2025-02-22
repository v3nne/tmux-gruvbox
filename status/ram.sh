PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

show_ram() {
  local index=$1
  local icon=$(get_tmux_option "@gruvbox_ram_icon" "󰍛")
  local color="$(get_tmux_option "@gruvbox_ram_color" "#${thm_magenta}")"
  local text="#(${PLUGIN_DIR}/../helpers/get_ram_percentage.sh)"
  local module=$(build_status_module "$index" "$icon" "$color" "$text")

  echo "$module"
}
