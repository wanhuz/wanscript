#!/usr/bin/env python
from plexapi.server import PlexServer
import datetime

baseurl = 'http://ipofplexserver:32400'
token = 'yourplextoken'
plex = PlexServer(baseurl, token)

plexlib = plex.library.section('yourlibrarynametorefresh')
response = plexlib.update()
print(response)
x = datetime.datetime.now()
print(x)
