source $(dirname $0)/000-dependency_installer.zsh

_woot_check_tool_in_path() {
  local offer_install=false
  if [[ "$1" == "--offer-install" ]]; then
    offer_install=true
    shift
  fi 

  tool_name="$1"
  tool_expected_version="$2"

  if ! command -v "$tool_name" >/dev/null 2>/dev/null; then 
    echo "Tool not found: $tool_name"
    
    if [[ "$offer_install" == "true" ]]; then 
      _woot_try_install_package "$tool_name"
    else
      return 1
    fi
  fi

  tool_version=$(${tool_name} --version)
  if [[ "$tool_version" != *${tool_expected_version}* ]]; then 
    echo "Tool is the wrong version: $tool_name $tool_version"
    echo "Expected $tool_expected_version"
    return 1
  fi
}