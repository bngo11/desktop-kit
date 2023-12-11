#!/usr/bin/env python3

import json
import re


async def generate(hub, **pkginfo):
	hplip_url = "https://developers.hp.com/hp-linux-imaging-and-printing/release_notes"
	dist_url = "https://sourceforge.net/projects/hplip/files/hplip/{0}/hplip-{0}.tar.gz"
	patch_url = "https://dev.gentoo.org/~billie/distfiles/hplip-{0}-patches-1.tar.xz"
	hplip_data = await hub.pkgtools.fetch.get_page(hplip_url)
	version = re.findall(r"HPLIP (\d+\.\d+\.\d+)", hplip_data)[0]
	hplip_version = re.findall(r"(\d+\.\d+).\d+", version)[0] + ".0"
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		hplip_version=hplip_version,
		artifacts=[hub.pkgtools.ebuild.Artifact(url=dist_url.format(version)),
					hub.pkgtools.ebuild.Artifact(url=patch_url.format(version))],
	)
	ebuild.push()
