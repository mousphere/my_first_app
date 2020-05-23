FROM ruby:2.6

# シェルスクリプトとしてbashを利用
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# 必要なライブラリインストール
RUN apt-get update && apt-get install -y build-essential libpq-dev 

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install nodejs

# yarnパッケージ管理ツールインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

RUN mkdir /my_app
WORKDIR /my_app
COPY Gemfile /my_app/Gemfile
COPY Gemfile.lock /my_app/Gemfile.lock
RUN bundle install
RUN bundle exec rails webpacker:install
RUN bundle exec rails webpacker:install:react
COPY . /my_app