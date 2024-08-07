#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/controlzee/asdf-chromium"
TOOL_NAME="chromium"

source "${plugin_dir}/lib/os_specific.bash"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if chromium is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	# this is an example of how to fetch versions via the release tags.
	# we aren't using this for chromium.
	GH_REPO="https://github.com/drawdb-io/drawdb"
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_folder_names() {
	# we have about a bajillion snapshots that we could fetch with paging, but honestly is it worth it?
	# you're never going to want to do that.
	URL="https://www.googleapis.com/storage/v1/b/chromium-browser-snapshots/o?delimiter=/&prefix=${DOWNLOAD_PREFIX}/&fields=items(kind,mediaLink,metadata,name,size,updated),kind,prefixes,nextPageToken&pageToken="
}

list_latest_version() {
	URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/${DOWNLOAD_PREFIX}%2FLAST_CHANGE?alt=media"
	curl "$URL"
}

list_all_versions() {
	# for now, rather than parsing a thousand versions, just return the latest version.
	# You can still manually pick a version it just won't appear on this list
	list_latest_version

	# list_folder_names
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	# url="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Mac_Arm%2F1000235%2Fchrome-mac.zip?generation=1651810093403336&alt=media"
	url="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/${DOWNLOAD_PREFIX}%2F${version}%2F${DOWNLOAD_FOLDER}.zip?alt=media" #?generation=1651810093403336&alt=media"
	echo "* Downloading $TOOL_NAME release $version for $DOWNLOAD_PREFIX..."
	echo curl "${curl_opts[@]}" -o "$filename" -C - "$url"
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%}"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		# TODO: Assert chromium executable exists.
		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
