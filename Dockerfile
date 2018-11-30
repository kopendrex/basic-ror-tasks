# Strict version applied, Gemfile declares it and fails when there is a difference
FROM ruby:2.5.3

# v8 runtime -- dependency for execjs
RUN apt update ; apt install -y nodejs

# Keep the app data in /srv
RUN mkdir -p /srv
WORKDIR /srv

# Dependencies for RoR app
COPY Gemfile Gemfile.lock /srv/
RUN bundle install

# Copy the RoR app
COPY . /srv

# No default values for CMD, EXPOSE, VOLUME or ENV specified here.
# Will be provided by docker-compose.yml
