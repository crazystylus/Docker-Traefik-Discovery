# Copyright (C) 2021  Kartik Sharma

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

FROM golang:1.15
WORKDIR /go/src/app
COPY app/ .

RUN go get -d -v ./...
RUN go install -v ./...
CMD ["app"]

