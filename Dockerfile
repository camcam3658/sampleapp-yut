FROM ruby:2.7.6

ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=1

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn
WORKDIR /myapp
COPY ./src /myapp
COPY src/Gemfile /myapp/Gemfile
COPY src/Gemfile.lock /myapp/Gemfile.lock
RUN bundle config --local set path 'vendor/bundle' \
  && bundle install

RUN yarn install --check-files
# RUN bundle exec rails webpacker:install


COPY start.sh /start.sh
RUN chmod 744 /start.sh
CMD ["sh", "/start.sh"]