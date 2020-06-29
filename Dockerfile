FROM ruby:2.7.1-alpine3.11 

ENV APP_HOME /blog-posts

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt install curl
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn
RUN apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
#RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
#RUN curl -sSL https://get.rvm.io | bash -s stable
#RUN source ~/.rvm/scripts/rvm
#RUN rvm install 2.7.1
#RUN rvm use 2.7.1 --default
RUN gem install bundler
RUN gem install rails -v 6.0.2.2
RUN apt-get install mysql-server mysql-client libmysqlclient-dev

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Add our Gemfile and install gems
ADD Gemfile* $APP_HOME/
RUN bundle install

# Copy over our application code
ADD . $APP_HOME

# Run our app
CMD RAILS_ENV=${RAILS_ENV} bundle exec rails db:create db:migrate db:seed && bundle exec rails s -p ${PORT} -b '0.0.0.0'