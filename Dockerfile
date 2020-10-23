FROM ruby:alpine as builder

RUN apk update
RUN apk add --virtual build-dependencies build-base
RUN gem install rubocop -v 1.0.0
RUN gem install brakeman -v 4.10.0
RUN find /usr/local/bundle
RUN which rubocop
RUN which brakeman
RUN find /usr/local/bundle/gems -name "*.c" -delete
RUN find /usr/local/bundle/gems -name "*.o" -delete

FROM ruby:alpine

WORKDIR /workdir
COPY --from=builder /usr/local /usr/local
RUN apk update && apk add --no-cache git openjdk8 openssh-client
