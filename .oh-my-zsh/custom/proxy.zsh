#!/bin/zsh

# Function to automatically detect and apply system proxy settings
function apply_system_proxy() {
  # Check the proxy settings for Wi-Fi using networksetup
  PROXY_SETTINGS=$(networksetup -getwebproxy Wi-Fi)

  # If Wi-Fi proxy is enabled
  if [[ "$PROXY_SETTINGS" == *"Enabled"* ]]; then
    # Extract the proxy address and port
    PROXY_ADDRESS=$(echo "$PROXY_SETTINGS" | grep "Server" | awk '{print $2}')
    PROXY_PORT=$(echo "$PROXY_SETTINGS" | grep "Port" | awk '{print $2}')
    echo "Wifi proxy found."

    export http_proxy="http://$PROXY_ADDRESS:$PROXY_PORT"
    export https_proxy="https://$PROXY_ADDRESS:$PROXY_PORT"
    export all_proxy="socks5://$PROXY_ADDRESS:$PROXY_PORT"
  else
    echo "No proxy found for Wi-Fi. Checking wired connection..."

    # If no proxy for Wi-Fi, check the proxy settings for Ethernet (wired connection)
    PROXY_SETTINGS=$(networksetup -getwebproxy Ethernet)

    if [[ "$PROXY_SETTINGS" == *"Enabled"* ]]; then
      PROXY_ADDRESS=$(echo "$PROXY_SETTINGS" | grep "Server" | awk '{print $2}')
      PROXY_PORT=$(echo "$PROXY_SETTINGS" | grep "Port" | awk '{print $2}')
      echo "Ethernet proxy found."

      export http_proxy="http://$PROXY_ADDRESS:$PROXY_PORT"
      export https_proxy="https://$PROXY_ADDRESS:$PROXY_PORT"
      export all_proxy="socks5://$PROXY_ADDRESS:$PROXY_PORT"
    else
      echo "No proxy found for both Wi-Fi and Ethernet."
    fi
  fi
}

# Function to display the current proxy settings in the command line
function display_current_proxy() {
  # Check if the http_proxy and https_proxy environment variables are set
  if [[ -z "$http_proxy" ]] && [[ -z "$https_proxy" ]]; then
    echo "No proxy is currently set."
  else
    echo "Current proxy settings:"
    echo "HTTP Proxy: $http_proxy"
    echo "HTTPS Proxy: $https_proxy"
    echo "ALL PROXY: $all_proxy"
  fi
}

# Call the function to apply the system proxy settings
apply_system_proxy

# Call the function to display the current proxy settings
display_current_proxy
