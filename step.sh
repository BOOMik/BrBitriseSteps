#!/bin/bash

# exit if a command fails
set -e
#
# Required parameters
if [ -z "${info_plist_file}" ] ; then
  echo " [!] Missing required input: info_plist_file"
  exit 1
fi

if [ -z "${bundle_name}" ] ; then
  echo " [!] No bundle_name specified!"
  exit 1
fi
if [ -z "${bundle_id}" ] ; then
  echo " [!] No bundle_id specified!"
  exit 1
fi
if [ -z "${icon}" ] ; then
  echo " [!] No icon specified!"
  exit 1
fi
if [ -z "${launch}" ] ; then
  echo " [!] No launch specified!"
  exit 1
fi
if [ -z "${logo}" ] ; then
  echo " [!] No logo specified!"
  exit 1
fi
if [ -z "${app_id}" ] ; then
  echo " [!] No app_id specified!"
  exit 1
fi


# ---------------------
# --- Configs:

echo " (i) Provided Info.plist file path: ${info_plist_file}"
echo " (i) Provided bundle_name: ${bundle_name}"
echo " (i) Provided bundle_id: ${bundle_id}"
echo " (i) Provided icon: ${icon}"
echo " (i) Provided launch: ${launch}"
echo " (i) Provided logo: ${logo}"
echo " (i) Provided app_id: ${app_id}"

# ---------------------
# --- Main:

# verbose / debug print commands
#set -v

echo ""
echo ""
echo " (i) Replacing..."

ORIGINAL_BUNDLE_VERSION="$(/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" "${info_plist_file}")"
echo " (i) Original Bundle Version: $ORIGINAL_BUNDLE_VERSION"
ORIGINAL_BUNDLE_SHORT_VERSION="$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "${info_plist_file}")"
echo " (i) Original Bundle Short Version String: $ORIGINAL_BUNDLE_SHORT_VERSION"



/usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName ${bundle_name}" "${info_plist_file}"
/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier ${bundle_id}" "${info_plist_file}"
/usr/libexec/PlistBuddy -c "Set :XSAppIconAssets ${icon}" "${info_plist_file}"
/usr/libexec/PlistBuddy -c "Set :XSLaunchImageAssets ${launch}" "${info_plist_file}"
/usr/libexec/PlistBuddy -c "Set :Logo ${logo}" "${info_plist_file}"
/usr/libexec/PlistBuddy -c "Set :AppId ${app_id}" "${info_plist_file}"

REPLACED_CFBundleDisplayName="$(/usr/libexec/PlistBuddy -c "Print :CFBundleDisplayName" "${info_plist_file}")"
echo " (i) Replaced CFBundleDisplayName: $REPLACED_CFBundleDisplayName"
REPLACED_logo="$(/usr/libexec/PlistBuddy -c "Print :logo" "${info_plist_file}")"
echo " (i) Replaced Bundle Short Version String: $REPLACED_logo"

# ==> Bundler version patched in Info.plist file for iOS project