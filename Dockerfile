FROM --platform=amd64 ruby:2.5.1

WORKDIR /usr/src/app

# ruby:2.5.1で使用されているdebian9(stretch)のパッケージリポジトリが移動したため変更する
COPY sources.list /etc/apt/sources.list

RUN wget -qO- https://deb.nodesource.com/setup_12.x | bash -

RUN set -ex \
    && apt-get update \
    && apt-get install -y \
                nodejs \
                # for chrome packages
                fonts-liberation libappindicator3-1 libasound2 \
                libnspr4 libxtst6 libnss3 libxss1 xdg-utils lsb-release \
                --no-install-recommends

# seleniumを使ったテストを行うためにchromeをインストール
#RUN curl -O https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
#     dpkg -i google-chrome-stable_current_amd64.deb

# chromiumならインストールできるけど、サンプルコードを実行してもエラーになる
RUN apt-get install -y \
                chromium \
                chromium-driver \
                --no-install-recommends

RUN npm install -g yarn

COPY Gemfile Gemfile.lock ./
RUN bundle install

# サンプルコード実行のため
RUN apt install -y python3-pip
RUN python3 -m pip install selenium

# Entrypoint prepares the database.
ENTRYPOINT ["./docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
