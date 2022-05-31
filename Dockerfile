####################################################################
#                           BUILD STAGE                            #
####################################################################

# This stage is for installing sqlite3
# as it takes some time that can be saved
# when you need to rebuild container
# It also helps to keep final image smaller
# because of selectively copying artifacts
# from one stage to another, leaving behind
# everything you don’t want in the final image

FROM ruby:2.7.5-alpine AS builder

ARG PACKAGES="alpine-sdk build-base \
           tcl-dev tk-dev mesa-dev \
           jpeg-dev libjpeg-turbo-dev"

RUN \
  apk update && \
  apk upgrade && \
  apk add $PACKAGES

# download sqlite3, latest release
RUN \
  wget -O sqlite.tar.gz \
    https://www.sqlite.org/src/tarball/sqlite.tar.gz?r=release && \
  tar xvfz sqlite.tar.gz

# configure and make SQLite3 binary
RUN \
  ./sqlite/configure --prefix=/usr && \
  make && make install

####################################################################
#                              MAIN STAGE                          #
####################################################################

# TODO configure non-root user inside this container

FROM ruby:2.7.5-alpine

COPY --from=builder /usr/bin/sqlite3 /usr/bin/sqlite3

# create user and group for sqlite3 to avoid: Dockle CIS-DI-0001
ENV \
  USER_SQLITE=sqlite \
  GROUP_SQLITE=sqlite

RUN \
  addgroup -S $GROUP_SQLITE && \
  adduser -S $USER_SQLITE -G $GROUP_SQLITE

ARG RAILS_ROOT=/rails-app
ARG PACKAGES="vim openssl-dev postgresql-dev \
              build-base curl nodejs yarn less tzdata git \
              postgresql-client bash screen shared-mime-info \
              sqlite sqlite-dev"

RUN \
  apk update && \
  apk upgrade && \
  apk add --update --no-cache $PACKAGES

# install bundler
RUN gem install bundler:2.1.4

WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 5

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# add binaries from bin to PATH
ENV PATH=$RAILS_ROOT/bin:$PATH

EXPOSE 3000
CMD bundle exec rails s -b '0.0.0.0' -p 3000
