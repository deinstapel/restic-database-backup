FROM restic/restic:0.14.0

RUN apk add --no-cache ca-certificates
RUN apk add --no-cache postgresql-client mysql-client bash tar influxdb curl jq

ENTRYPOINT ["/bin/bash"]
