FROM mozilla/mozphab:f7286bdfdd60854764d3910747461a1cef3366b5

COPY extensions /app/moz-extensions

# Move static resources to phabricator, add files to celerity map array
COPY extensions/src/auth/PhabricatorBMOAuth.css /app/phabricator/webroot/rsrc/css/PhabricatorBMOAuth.css
COPY extensions/src/auth/PhabricatorBMOAuth.js /app/phabricator/webroot/rsrc/js/PhabricatorBMOAuth.js

USER root

# Install dependencies
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_VENDOR_DIR /app/phabricator/externals/extensions
RUN \
    curl -sS https://getcomposer.org/installer | php && \
    php composer.phar require --no-plugins --no-scripts "sentry/sentry"

# Apply customization patches
COPY patches /app/patches
RUN \
    cd /app/phabricator && \
    for i in /app/patches/phabricator/*.patch; do patch -p1 < $i; done

# Configure Phabricator to use moz-extensions library
RUN \
    mkdir /app/phabricator/conf/custom/ && \
    echo custom/moz-extensions > /app/phabricator/conf/local/ENVIRONMENT
COPY moz-extensions.conf.php /app/phabricator/conf/custom/

# Update build_url in version.json
COPY phabext.json /app
COPY update_build_url.py /app
RUN /app/update_build_url.py

RUN chown -R app:app /app
USER app
VOLUME ["/app"]
