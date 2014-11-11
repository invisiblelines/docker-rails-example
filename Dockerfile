FROM invisiblelines/ruby:2.1.4
MAINTAINER Kieran Johnson <kieran@invisiblelines.com>

ENV RAILS_ENV development
ENV PORT 5000

RUN curl -sL https://deb.nodesource.com/setup | sudo bash - && \
    apt-get -qqy install nodejs -y; \
    apt-get clean -y; \
    apt-get autoremove -y

RUN apt-get -qq update;\
  apt-get -qqy install sqlite libsqlite3-dev; \
  apt-get clean -y; \
  apt-get autoremove -y

RUN adduser web --no-create-home --shell /bin/bash --disabled-password --gecos ""

RUN mkdir -p /var/bundle && chown -R web:web /var/bundle
RUN mkdir -p /var/www && chown -R web:web /var/www

ADD Gemfile /var/www/
ADD Gemfile.lock /var/www/

RUN bundle config --global path /var/bundle
RUN su web -c "cd /var/www && bundle install --path /var/bundle"

USER web

WORKDIR /var/www

EXPOSE $PORT

CMD bundle exec foreman start
