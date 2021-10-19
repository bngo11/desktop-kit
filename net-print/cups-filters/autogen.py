#!/usr/bin/env python3

import json

async def generate(hub, **pkginfo):
	json_data = await hub.pkgtools.fetch.get_page("https://api.github.com/repos/OpenPrinting/cups-filters/releases", is_json=True)
	version = None

	if "version" not in pkginfo:
		for release in json_data:
			try:
				if release["prerelease"] or release["draft"]:
					continue
				version = release["tag_name"]
				url = release["assets"][-1]["browser_download_url"]
				break

			except KeyError:
				continue
	else:
		version = pkginfo["version"]

	if version and url:
		name = pkginfo["name"]
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url)],
		)

		ebuild.push()

# vim: ts=4 sw=4 noet
