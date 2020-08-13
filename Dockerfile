FROM debian:buster-slim

ENV DEBIAN_FRONTEND="noninteractive"
ENV TZ="Europe/London"

RUN apt-get update && apt-get install -y \
      chromium \
      chromium-l10n \
      fonts-liberation \
      fonts-roboto \
      hicolor-icon-theme \
      libcanberra-gtk-module \
      libexif-dev \
      libgl1-mesa-dri \
      libgl1-mesa-glx \
      libpango1.0-0 \
      libv4l-0 \
      fonts-symbola \
      curl \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /etc/chromium.d/ \
    && /bin/echo -e 'export GOOGLE_API_KEY="AIzaSyCkfPOPZXDKNn8hhgu3JrA62wIgC93d44k"\nexport GOOGLE_DEFAULT_CLIENT_ID="811574891467.apps.googleusercontent.com"\nexport GOOGLE_DEFAULT_CLIENT_SECRET="kdloedMFGdGla2P1zacGjAQh"' > /etc/chromium.d/googleapikeys

# Add chromium user
RUN groupadd -r chromium && useradd -r -g chromium -G audio,video chromium \
    && mkdir -p /home/chromium/Downloads && chown -R chromium:chromium /home/chromium

RUN set -ex; \
    apt-get update \
    && apt-get install -y --no-install-recommends gcc libc-dev curl\
    && curl -k -o /tmp/su-exec.c https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c \
    && rm -rf /var/lib/apt/lists/* \
    && gcc -Wall /tmp/su-exec.c -o /usr/bin/su-exec \
    && chown root:root /usr/bin/su-exec \
    && chmod 700 /usr/bin/su-exec \
    && rm /tmp/su-exec.c \
    && apt-get purge -y --auto-remove gcc libc-dev

ENTRYPOINT ["su-exec", "chromium", "/usr/bin/chromium" ]
CMD ["--user-data-dir=/data"]

