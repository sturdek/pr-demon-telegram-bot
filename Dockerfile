FROM ruby:2.3
MAINTAINER KC <kwancheng.lai@gmail.com>

WORKDIR /usr/app

COPY Gemfile Gemfile.lock /usr/app/
RUN bundle install

COPY . /usr/app

ENTRYPOINT ["ruby", "app.rb"]
