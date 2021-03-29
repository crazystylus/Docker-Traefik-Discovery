#!/bin/bash

# Copyright (C) 2021  Kartik Sharma

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

echo """
traefik.enable=true
traefik.http.routers.myapi${APIVERSION}.entrypoints=http
traefik.http.routers.myapi${APIVERSION}.rule=PathPrefix(\`/myapi/v${APIVERSION}{regex:$$|/.*}\`)
traefik.http.routers.myapi${APIVERSION}.middlewares=myapi${APIVERSION}-strip
traefik.http.middlewares.myapi${APIVERSION}-strip.stripprefix.prefixes=/myapi/v${APIVERSION}""" | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/ -l /g'