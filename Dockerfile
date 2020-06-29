FROM ruby:2.7.1

ENV APP_HOME /blog-posts

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN apt install curl
RUN apt-get update

RUN gem install bundler
RUN gem install rails -v 6.0.2.2

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Add our Gemfile and install gems
COPY Gemfile* $APP_HOME/
RUN bundle install

# Copy over our application code
COPY . $APP_HOME

# Run our app
CMD RAILS_ENV=${RAILS_ENV} bundle exec rails db:create db:migrate db:seed && bundle exec rails s -p ${PORT} -b '0.0.0.0'