FROM ruby:2.5.8

RUN apt-get update -qq && \
  apt-get install -y apt-utils \
  build-essential \
  libpq-dev \
  nodejs \
  vim \
  default-mysql-client

WORKDIR /app

COPY Gemfile* /app

RUN bundle install

COPY . /app