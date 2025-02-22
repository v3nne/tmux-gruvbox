PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


get_weather_icon() {
  local weather="$1"
  # Enable case-insensitive matching
  shopt -s nocasematch

  if [[ "$weather" =~ (clear|sunny) ]]; then
    echo "󰖨"
  elif [[ "$weather" =~ partly[[:space:]]*cloudy ]]; then
    echo "󰖕"
  elif [[ "$weather" =~ (cloudy|overcast) ]]; then
    echo "󰖐"
  elif [[ "$weather" =~ (mist|fog) ]]; then
    echo "🌫️"
  elif [[ "$weather" =~ drizzle ]]; then
    echo "🌦️"
  elif [[ "$weather" =~ rain ]]; then
    echo "🌧️"
  elif [[ "$weather" =~ thunderstorm ]]; then
    echo "⛈️"
  elif [[ "$weather" =~ snow ]]; then
    echo "❄️"
  elif [[ "$weather" =~ sleet ]]; then
    echo "🌨️"
  elif [[ "$weather" =~ hail ]]; then
    echo "🌨️"
  else
    # Fallback icon if no match is found
    touch ./tmux-weather.log
    echo "Could not find match for weather: ${weather}" >> ./tmux-weather.log
    echo ""
  fi

  # Disable case-insensitive matching to avoid affecting other parts of the script
  shopt -u nocasematch
}


show_weather() {
  # IFS='|' read -r weather temp <<< "$(curl -s 'wttr.in/?format=%C|%t')"

  local index=$1
  local icon="$(get_tmux_option "@gruvbox_weather_icon" "󰖐")"
  local color="$(get_tmux_option "@gruvbox_weather_color" "$thm_blue")"
  local text="#(${PLUGIN_DIR}/../helpers/get_weather.sh)"

  local module=$( build_status_module "$index" "$icon" "$color" "$text" )

  echo "$module"
}
