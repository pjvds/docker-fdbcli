# Dockerfile
#
# This source file is part of the FoundationDB open source project
#
# Copyright 2013-2018 Apple Inc. and the FoundationDB project authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && \
	apt-get install -y curl>=7.58.0-2ubuntu3.6 \
	dnsutils>=1:9.11.3+dfsg-1ubuntu1.7 && \
	rm -r /var/lib/apt/lists/*

# Install FoundationDB Binaries
ARG FDB_VERSION=6.1.8
ARG FDB_WEBSITE=https://www.foundationdb.org

WORKDIR /var/fdb/tmp
RUN curl $FDB_WEBSITE/downloads/$FDB_VERSION/linux/fdb_$FDB_VERSION.tar.gz -o fdb_$FDB_VERSION.tar.gz && \
	tar -xzf fdb_$FDB_VERSION.tar.gz --strip-components=1 && \
	rm fdb_$FDB_VERSION.tar.gz && \
	chmod u+x fdbcli && \
	mv fdbcli /usr/bin/ && \
	rm -r /var/fdb/tmp

COPY fdbcli.bash /fdb/scripts/
RUN chmod u+x /fdb/scripts/fdbcli.bash

ENTRYPOINT ["/fdb/scripts/fdbcli.bash"]
