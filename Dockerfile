FROM ruby:2.6.3

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

RUN mkdir /Habit-is-power
WORKDIR /Habit-is-power                    
COPY Gemfile /Habit-is-power/Gemfile
COPY Gemfile.lock /Habit-is-power/Gemfile.lock
RUN bundle install
COPY . /Habit-is-power

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]         #コンテナ起動時、一番最初に実行されるコマンド
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]