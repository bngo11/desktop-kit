#!/usr/bin/env python3

from bs4 import BeautifulSoup
import requests

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
				patch_ver = 1
				patch_url = None
				while patch_ver < 11:
					purl = f"https://dev.gentoo.org/~billie/distfiles/hplip-{version}-patches-{patch_ver}.tar.xz"
					res = requests.head(purl)
					if res.status_code == 200:
						patch_url = purl
					else:
						break
					patch_ver += 1
				else:
					continue
				if patch_url:
					break

			except ValueError:
				continue

	if version and patch_url:
		url = f"https://sourceforge.net/projects/hplip/files/hplip/{version}/hplip-{version}.tar.gz"
		hplip = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			template="hplip.tmpl",
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url),
						hub.pkgtools.ebuild.Artifact(url=patch_url)],
		)
		hplip.push()

		url = f"https://www.openprinting.org/download/printdriver/auxfiles/HP/plugins/hplip-{version}-plugin.run"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			cat="net-print",
			name="hplip-plugin",
			template="hplip-plugin.tmpl",
			template_path=hplip.template_path,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url)],
		)
		ebuild.push()



# vim: ts=4 sw=4 noet
