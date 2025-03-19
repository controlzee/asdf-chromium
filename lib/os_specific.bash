#!/usr/bin/env bash

# export the os specific variables/commands

DOWNLOAD_PREFIX="Mac_Arm"
DOWNLOAD_FOLDER="chrome-mac"
DOWNLOAD_FILE_NAME="Chromium.app"
TOOL_TEST="chrome/Chromium.app/Contents/MacOS/Chromium --help"
# IS_ON_JENKINS="${JENKINS_USER}" # for now check if this is set
IS_ON_JENKINS_MISE="false"

if [[ "$(uname -m)" == "aarch64" ]]; then
	# Jenkins
	DOWNLOAD_PREFIX="Linux_ARM_Cross-Compile"
	DOWNLOAD_FOLDER="chrome-linux"
	# at the moment we're renaming the linked folder instead of
	# the main folder so that we can transition smoothly over, since most branches still use the
	# fully qualified name
    DOWNLOAD_FILE_NAME="chrome"
	TOOL_TEST="chrome/chrome --help"
	IS_ON_JENKINS_MISE="true"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	# linux -- probably not jenkins?
	DOWNLOAD_PREFIX="Linux"
	DOWNLOAD_FOLDER="chrome-linux"
    DOWNLOAD_FILE_NAME="chrome"
	TOOL_TEST="chrome/chrome --help"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	# Mac OSX
	if [[ $(uname -m) == 'arm64' ]]; then
		DOWNLOAD_PREFIX="Mac_Arm"
	else
		DOWNLOAD_PREFIX="Mac"
	fi
	DOWNLOAD_FOLDER="chrome-mac"
    DOWNLOAD_FILE_NAME="Chromium.app"
	TOOL_TEST="chrome/Chromium.app/Contents/MacOS/Chromium --help" # go inside the mac app to run it!
elif [[ "$OSTYPE" == "cygwin" ]]; then
	# POSIX compatibility layer and Linux environment emulation for Windows
	DOWNLOAD_PREFIX="Win"
	DOWNLOAD_FOLDER="chrome-win"
    DOWNLOAD_FILE_NAME="chrome.exe"
    TOOL_TEST="chrome/chrome.exe --help"
elif [[ "$OSTYPE" == "msys" ]]; then
	# Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
	DOWNLOAD_PREFIX="Win"
	DOWNLOAD_FOLDER="chrome-win"
    DOWNLOAD_FILE_NAME="chrome.exe"
    TOOL_TEST="chrome/chrome.exe --help"
fi


export \
    TOOL_TEST \
    DOWNLOAD_PREFIX \
    DOWNLOAD_FOLDER \
    DOWNLOAD_FILE_NAME \
	IS_ON_JENKINS_MISE