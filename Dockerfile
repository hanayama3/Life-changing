FROM ruby:2.6.3

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

RUN mkdir /Life-changing
WORKDIR /Life-changing                    
COPY Gemfile /Life-changing/Gemfile
COPY Gemfile.lock /Life-changing/Gemfile.lock
RUN bundle install
COPY . /Life-changing

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]         #コンテナ起動時、一番最初に実行されるコマンド
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]