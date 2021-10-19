#!/usr/bin/env python3

import json
from datetime import timedelta

async def generate(hub, **pkginfo):
	text_data = await hub.pkgtools.fetch.get_page("https://gitlab.com/api/v4/projects/8656645/releases")
	text_json = json.loads(text_data)[0]
	version = text_json['name']

	final_name = f"plata-theme-{version}.tar.gz"
	url = f"https://gitlab.com/tista500/plata-theme/-/archive/{version}/{final_name}"
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		artifacts=[hub.pkgtools.ebuild.Artifact(url=url)]
	)
	ebuild.push()

# vim: ts=4 sw=4 noet
