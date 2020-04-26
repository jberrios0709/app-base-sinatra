FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential
ENV APP_HOME /app
WORKDIR /usr/src/app
COPY ./app/Gemfile /usr/src/app
RUN bundle install
EXPOSE 4567
CMD ["rackup", "-p", "4567", "-o", "0.0.0.0"]
