#!/usr/bin/env python3

from bs4 import BeautifulSoup

async def generate(hub, **pkginfo):
	html_data = await hub.pkgtools.fetch.get_page("https://sourceforge.net/projects/hplip/files/hplip/")
	soup = BeautifulSoup(html_data, "html.parser")
	links = soup.find_all("a")
	version = None

	for link in links:
		href = link.get("href")
		if href and "files" in href:
			parts = href.split("/")
			version = parts[-2]

			try:
				list(map(int, version.split(".")))
				break

			except ValueError:
				continue

	if version:
		url = f"https://sourceforge.net/projects/hplip/files/hplip/{version}/hplip-{version}.tar.gz"
		patch_url = f"https://dev.gentoo.org/~billie/distfiles/hplip-{version}-patches-1.tar.xz"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url),
						hub.pkgtools.ebuild.Artifact(url=patch_url)],
		)

		ebuild.push()


# vim: ts=4 sw=4 noet
