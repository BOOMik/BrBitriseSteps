#!/bin/bash

# exit if a command fails
set -e
#
# Required parameters
if [ -z "${file}" ] ; then
  echo " [!] Missing required input: file"
  exit 1
fi
if [ -z "${old_value}" ] ; then
  echo " [!] No old_value specified!"
  exit 1
fi
if [ -z "${new_value}" ] ; then
  echo " [!] No new_value specified!"
  exit 1
fi


# ---------------------
# --- Configs:

echo " (i) Provided file path: ${file}"
echo " (i) Provided old_value: ${old_value}"
echo " (i) Provided new_value: ${new_value}"

if [ "${show_file}" == "true" ]; then
echo "------------------------------------------"
echo "------------------------------------------"
echo "------------------------------------------"
echo "-------------OLD  FILE--------------------"
echo "------------------------------------------"
echo "------------------------------------------"
echo "------------------------------------------"
cat ${file}
fi

# ---------------------
# --- Main:

# verbose / debug print commands
#set -v
sed -i -e 's/'"${old_value}"'/'"${new_value}"'/g' ${file}

if [ "${show_file}" == "true" ]; then
echo "------------------------------------------"
echo "------------------------------------------"
echo "------------------------------------------"
echo "-------------NEW  FILE--------------------"
echo "------------------------------------------"
echo "------------------------------------------"
echo "------------------------------------------"
cat ${file}
fi

# ==> Bundler version patched in Info.plist file for iOS project