#!/bin/bash
if [[ -n "$FDB_CLUSTER_FILE_CONTENTS" ]]; then
  mkdir -p /etc/foundationdb
  echo "$FDB_CLUSTER_FILE_CONTENTS" > /etc/foundationdb/fdb.cluster
else
	echo "FDB_CLUSTER_FILE_CONTENTS environment variable not defined" 1>&2
	exit 1
fi

fdbcli "$@"
