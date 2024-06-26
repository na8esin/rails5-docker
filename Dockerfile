FROM ruby:2.5.1

WORKDIR /usr/src/app

# ruby:2.5.1で使用されているdebian9(stretch)のパッケージリポジトリが移動したため変更する
COPY sources.list /etc/apt/sources.list

RUN wget -qO- https://deb.nodesource.com/setup_12.x | bash -

RUN set -ex \
    && apt-get update \
    && apt-get install -y \
                nodejs \
                --no-install-recommends

RUN npm install -g yarn

COPY Gemfile Gemfile.lock ./
RUN bundle install

EXPOSE 3000
EXPOSE 4444
EXPOSE 5900
EXPOSE 7900

# サンプルコード実行のため
RUN apt install -y python3-pip
RUN python3 -m pip install selenium

# Entrypoint prepares the database.
ENTRYPOINT ["./docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
