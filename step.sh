#!/bin/bash

# exit if a command fails
set -e
#
# Required parameters
if [ -z "${file}" ] ; then
  echo " [!] Missing required input: file"
  exit 1
fi


# ---------------------
# --- Configs:

echo " (i) Provided Info.plist file path: ${info_plist_file}"
# ---------------------
# --- Main:

# verbose / debug print commands
#set -v

echo ""
echo ""
echo " (i) Checking..."

ruby cert_checker.rb ${file}

cat ${info_plist_file}

# ==> Bundler version patched in Info.plist file for iOS project