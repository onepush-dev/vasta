# Vasta on Railway: the official upstream image (ariedotme/vasta, AGPL-3.0), app unmodified.
# Adds a start wrapper that fixes ownership of the Railway volume (/data) and, on the first boot only,
# creates the owner account "admin" from VASTA_ADMIN_PASSWORD with Vasta's own CLI (`vasta user add`),
# so no setup code from the logs is needed and nobody else can claim a fresh server.
# Defaults are baked as ENV because Railway templates drop plain variable values.
FROM ghcr.io/ariedotme/vasta:0.8.0
LABEL org.opencontainers.image.source="https://github.com/onepush-dev/vasta"
USER root
COPY railway/start.sh /opt/railway/start.sh
RUN chmod 755 /opt/railway/start.sh
ENV NODE_ENV=production \
    HOST=0.0.0.0 \
    PORT=8080 \
    VASTA_DATA=/data \
    VASTA_WEB_DIR=/app/web \
    VASTA_ADMIN_USER=admin \
    VASTA_ADMIN_NAME=Admin
EXPOSE 8080
HEALTHCHECK NONE
CMD ["/opt/railway/start.sh"]
