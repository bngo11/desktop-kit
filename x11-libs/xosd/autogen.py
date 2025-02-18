#!/usr/bin/env python3

from bs4 import BeautifulSoup

async def generate(hub, **pkginfo):
	html_data = await hub.pkgtools.fetch.get_page(f"https://sourceforge.net/projects/libxosd/files/libxosd")
	soup = BeautifulSoup(html_data, "html.parser")
	links = soup.find_all("span")
	version = None

	for link in links:
		cls = link.get("class")
		if cls and 'name' in cls:
			try:
				proj_dir = link.text
				version = proj_dir.split("-")[-1]
				list(map(int, version.split(".")))
				final_name = f"{proj_dir}.tar.gz"
				break

			except ValueError:
				continue

	if version:
		url = f"https://sourceforge.net/projects/libxosd/files/libxosd/{proj_dir}/{final_name}"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)],
		)

		ebuild.push()

# vim: ts=4 sw=4 noet
