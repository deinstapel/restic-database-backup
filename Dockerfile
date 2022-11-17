
ARG UBUNTU_VERSION="22.04"
ARG RESTIC_VERSION="0.14.0"

FROM restic/restic:${RESTIC_VERSION} as restic

FROM ubuntu:${UBUNTU_VERSION}

ARG MINIO_VERSION="mc.RELEASE.2022-10-29T10-09-23Z"
ARG AWS_CLI_VER="2.8.8"

# Setting DEBIAN_FRONTEND=noninteractive causes tzdata to assume UTC, which is exactly what we want
RUN export DEBIAN_FRONTEND=noninteractive && apt update && apt install -y --no-install-recommends ca-certificates mariadb-client bash tar influxdb curl jq openssh-client unzip tzdata && echo "deb http://apt.postgresql.org/pub/repos/apt jammy-pgdg main" > /etc/apt/sources.list.d/pgdg.list && curl https://www.postgresql.org/media/keys/ACCC4CF8.asc > /etc/apt/trusted.gpg.d/pgdg.asc && apt update && apt install -y --no-install-recommends postgresql-client-13 postgresql-client-14 postgresql-client-15 postgresql-client-12 && rm -rf /var/lib/apt/lists/*

# Download minio
RUN curl https://dl.min.io/client/mc/release/linux-amd64/$MINIO_VERSION > /usr/bin/mc && chmod +x /usr/bin/mc

# Copy restic into container
COPY --from=restic /usr/bin/restic /usr/bin/restic

# Download & Install AWS SDK
WORKDIR /tmp
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VER}.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install && rm -rf aws awscliv2.zip

ENTRYPOINT ["/bin/bash"]
