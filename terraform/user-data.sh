#!/bin/bash
set -euxo pipefail
dnf install -y nginx
systemctl enable --now nginx

cat > /usr/share/nginx/html/index.html <<'APPHTML'
${app_html}
APPHTML

cat > /usr/share/nginx/html/health.html <<'HEALTHHTML'
${health_html}
HEALTHHTML

chown -R nginx:nginx /usr/share/nginx/html
systemctl restart nginx
