#!/usr/bin/env python3

import json

async def generate(hub, **pkginfo):
	json_data = await hub.pkgtools.fetch.get_page("https://api.github.com/repos/intel/thunderbolt-software-user-space/releases", is_json=True)
	version = None

	for item in json_data:
		try:
			if not item['prerelease']:
				version = item['tag_name'].strip('v')
				list(map(int, version.split(".")))
				break

		except (IndexError, ValueError, KeyError):
			continue

	if version:
		url = f"https://github.com/intel/thunderbolt-software-user-space/archive/v{version}.tar.gz"
		url2 = f"https://dev.gentoo.org/~asturm/distfiles/thunderbolt-software-user-space-{version}-tbtadm.1.tar.xz"
		final_name = f"thunderbolt-software-user-space-{version}.tar.gz"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name), hub.pkgtools.ebuild.Artifact(url=url2)]
		)
		ebuild.push()

# vim: ts=4 sw=4 noet
