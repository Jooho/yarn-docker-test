FROM node:8-alpine

ENV HOME=/app
WORKDIR /app
RUN set -ex && \
    adduser node root && \
    chmod g+w /app && \
    apk add --update --no-cache \
      # newrelic
      g++ make python \
      # sonar-scanner
      openjdk8-jre

COPY .npmrc package.json yarn.lock /app/
RUN set -ex && \
    yarn install --pure-lockfile && \
    yarn cache clean && \
    rm .npmrc && \
    apk del g++ make python
COPY ./ /app/

USER node
EXPOSE 4000
ENTRYPOINT ["yarn"]
CMD ["start"]
