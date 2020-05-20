FROM ruby:2.6.3

# シェルスクリプトとしてbashを利用
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# 必要なライブラリインストール
RUN apt-get update && apt-get install -y build-essential nodejs　libpq-dev 

# yarnパッケージ管理ツールインストール
RUN curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
    apt-get install nodejs

RUN mkdir /rails
WORKDIR /rails
COPY Gemfile /rails/Gemfile
COPY Gemfile.lock /rails/Gemfile.lock
RUN bundle install
COPY . /rails