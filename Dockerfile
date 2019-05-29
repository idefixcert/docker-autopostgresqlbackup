FROM alpine

# Labels
LABEL maintainer="Charles Lu <github.com/charleszlu>"

# Environment variables (with default values)
ENV CRON_LOG_LEVEL=8

# Packages installation
RUN apk --update add --no-cache bash bzip2 gzip postgresql-client

# Copy files to the image
ADD autopostgresqlbackup.conf /etc/default/autopostgresqlbackup
ADD autopostgresqlbackup /usr/sbin/autopostgresqlbackup
RUN chmod 755 /usr/sbin/autopostgresqlbackup

# Configure entrypoint
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Volumes declaration
VOLUME ["/backups"]

# Start the container process
ENTRYPOINT ["/docker-entrypoint.sh"]
