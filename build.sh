#!/bin/bash

#===============================================================================
#
# FILE: build.sh
#
# USAGE: ./build.sh
#
# DESCRIPTION: Build a new WWUZEN sub-theme. Run this script to replace
#   instances of "wwuzen_template" in all theme php files with the name of the
#   new theme. The script will prompt for the target and replacement text,
#   allowing for flexibility and the ability to correct errors if the wrong
#   replacmeent text is entered. The script will also rename the .info file
#   appropriately.
#
#   The script will NOT set the human-readable theme name in the .info file.
#   This must be done manually. The displayed department name visible to users
#   is also not hard-coded; this must be set in the appearance settings for the
#   theme once it has been deployed and enabled.
#
#   grep, find, and sed are used to implement the functionality in this script.
#   grep shows the changes that will be made and allows the user to verify the
#   results. find locates the files in which the replacement will be performed,
#   and sed is responsible for the replacement operation.
#
# KNOWN ISSUES: This script fails to run on Mac OS X. It is recommended to run
#   from the WebTech Vagrant box or a similar Linux environment.
#
# ARGUMENTS:
#
# AUTHOR:
#   Nigel Packer 2015
#
#===============================================================================

# Set error options for bash
set -o errexit
set -o nounset
set -o pipefail

# Real directory of the script, not current working directory
readonly __DIR__="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
readonly __ROOT__="$(cd "$( dirname "${__DIR__}" )" && pwd)"
readonly __SELF__="${__DIR__}/$( basename "${BASH_SOURCE[0]}" )"
readonly __BASE__="$( basename "${__SELF__}" .sh )"

# Color escape sequences for coloring shell output
readonly GREEN='\033[0;32m'
readonly NC='\033[0m'

# Exclude search from directory
readonly EXCLUDE='.git'

# Print a message when exiting, possibly performing cleanup
__exitHandler() {
  wait

  local status=$?

  echo "Exiting"
  exit $status
}

# Trap errors and exit signals
trap __exitHandler \
  ERR EXIT SIGINT SIGTERM SIGQUIT

__main() {
  # Target text that will be searched and replaced
  local target=

  # Text with which target will be replaced
  local replacement=

  # Explain what the script will do
  read -p "  build.sh automates the creation of a drupal 7 child theme,
  https://www.drupal.org/node/225125. The script will NOT set the human-readable
  theme name in the .info file. This must be done manually. The displayed
  department name visible to users is also not hard-coded; this must be set in
  the appearance settings for the theme once it has been deployed and enabled.
  Press Enter to continue or CTRL+C to quit."

  # Get the target text from the user
  read -p "Enter the function name to replace, typically wwuzen_template: " target

  # Get the replacmeent text from the user
  read -p "Provide a new function name, such as wwuzen_new: " replacement

  # Test if the .info file exists to rename
  if [ ! -e "${target}.info" ]; then
    echo "The file ${target}.info does not exist so the replacment cannot proceed."
    exit 1
  fi

  # Output operations that will be performed
  echo
  echo -e "${GREEN}Will rename '${target}.info' to '${replacement}.info'${NC}"
  echo
  echo -e "${GREEN}Will replace '${target}' in the following locations:${NC}"
  grep --exclude="build.sh" --exclude-dir="${EXCLUDE}" --recursive --color=auto "${target}" .
  echo

  local proceed=
  # Prompt the user to continue the replacement
  read -p "Continue with replacement? [Y/n]: " proceed

  if [ ! $proceed == "Y" ]; then
    exit 2
  fi

  # Replacmenet expression for sed command
  local expression='s/'"${target}"'/'"${replacement}"'/g'

  # Find all php files recusively in the directory and run sed to replace the
  # given patterns
  find \
    . \
    ! -name "build.sh" \
    ! -name "${EXCLUDE}" \
    -type f \
    -exec sed \
    --in-place \
    --expression="${expression}" {} +

  # Rename the .info file
  mv "${target}.info" "${replacement}.info"

  # Output results of the operation
  echo
  echo -e "${GREEN}Renamed '${target}.info' to '${replacement}.info'${NC}"
  echo
  echo -e "${GREEN}Replaced '${target}' with '${replacement}':${NC}"
  grep --exclude="build.sh" --exclude-dir="${EXCLUDE}" --recursive --color=auto "${replacement}" .
  echo

  exit 0
}

__main $@
