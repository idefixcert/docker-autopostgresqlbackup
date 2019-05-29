FROM alpine

# Labels
LABEL maintainer="Charles Lu <github.com/charleszlu>"

# Environment variables (with default values)
ENV CRON_LOG_LEVEL=8

# Packages installation
RUN apk --update add --no-cache bash bzip2 gzip postgresql-client tzdata

# Copy files to the image
COPY autopostgresqlbackup.conf /etc/default/autopostgresqlbackup
COPY autopostgresqlbackup /usr/sbin/autopostgresqlbackup
RUN chmod 755 /usr/sbin/autopostgresqlbackup

# Configure entrypoint
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Volumes declaration
VOLUME ["/backups"]

# Start the container process
ENTRYPOINT ["/docker-entrypoint.sh"]
