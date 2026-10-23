#!/usr/bin/env python3

from bs4 import BeautifulSoup
from curl_cffi import requests

async def generate(hub, **pkginfo):
	html_data = requests.get("https://anydesk.com/en/downloads/linux", impersonate="chrome120")
	soup = BeautifulSoup(html_data.text, "html.parser")
	links = soup.find_all("a")
	url = None

	for link in links:
		href = link.get("href")
		if href and href.endswith("amd64.tar.gz"):
			url = href
			break

	if url:
		final_name = url.rsplit("/", 1)[-1]
		version = final_name.split("-")[1]
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)],
		)

		ebuild.push()


# vim: ts=4 sw=4 noet
