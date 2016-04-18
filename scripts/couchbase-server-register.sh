#!/usr/bin/env bash

if [ ! -e /lib/systemd/system/couchbase-server.service ]; then

cat > /lib/systemd/system/couchbase-server.service << EOF
# -*- mode: conf-unix; -*-
[Unit]
Description = Couchbase Server
Documentation = http://docs.couchbase.com
After = network.target remote-fs.target nss-lookup.target

[Service]
SyslogIdentifier = couchbase
User = couchbase
Type = forking
PIDFile=/opt/couchbase/var/lib/couchbase/couchbase-server.pid
WorkingDirectory = /opt/couchbase/var/lib/couchbase
LimitNOFILE = 40960
LimitCORE = unlimited
LimitMEMLOCK = unlimited
ExecStart = /opt/couchbase/bin/couchbase-server -noinput -detached > /opt/couchbase/var/lib/couchbase/logs/start.log 2>&1
ExecStop = /opt/couchbase/bin/couchbase-server -k

[Install]
WantedBy = multi-user.target
EOF

fi
