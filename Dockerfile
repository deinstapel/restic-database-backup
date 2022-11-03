FROM restic/restic:0.14.0

RUN apk add --no-cache ca-certificates
RUN apk add --no-cache postgresql-client mysql-client bash tar influxdb curl jq
ARG MINIO_VERSION="mc.RELEASE.2022-10-29T10-09-23Z"
RUN curl https://dl.min.io/client/mc/release/linux-amd64/$MINIO_VERSION > /usr/bin/mc && chmod +x /usr/bin/mc

ENTRYPOINT ["/bin/bash"]
