FROM ruby:2.5.1

WORKDIR /usr/src

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
#RUN curl -O https://dl.google.com/linux/direct/google-chrome-stable_current_arm64.deb && \
#     dpkg -i google-chrome-stable_current_arm64.deb

# chromiumならインストールできる
RUN apt-get install -y \
                chromium \
                chromium-driver \
                --no-install-recommends

RUN npm install -g yarn

COPY Gemfile Gemfile.lock ./
RUN bundle install
