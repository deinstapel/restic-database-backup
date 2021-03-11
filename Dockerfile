FROM alpine:3.11

RUN apk add --no-cache ca-certificates
RUN apk add --no-cache restic postgresql-client mysql-client bash tar influxdb curl jq

ENTRYPOINT ["/bin/bash"]
