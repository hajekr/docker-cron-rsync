FROM alpine:3

RUN apk add --no-cache \
    rsync \
    openssh-client \
    dcron

# Create .ssh dir with correct permissions
RUN mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
