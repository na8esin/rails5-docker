FROM --platform=amd64 ruby:2.5.1

# throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1

WORKDIR /usr/src

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .