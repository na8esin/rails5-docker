FROM --platform=amd64 ruby:2.5.1

WORKDIR /usr/src

# ruby:2.5.1で使用されているdebian9(stretch)のパッケージリポジトリが移動したため変更する
COPY containers/local/rails/sources.list /etc/apt/sources.list

RUN wget -qO- https://deb.nodesource.com/setup_12.x | bash -

RUN set -ex \
    && apt-get update \
    && apt-get install -y \
                 nodejs \
                --no-install-recommends
RUN npm install -g yarn

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .