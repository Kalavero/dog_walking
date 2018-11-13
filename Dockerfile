FROM ruby:2.5

ARG UID

ENV APP_USER=dog_walking APP_PATH=/dog_walking

RUN mkdir $APP_PATH && useradd -u $UID --home-dir $APP_PATH $APP_USER

RUN apt-get update && apt-get install -y build-essential libpq-dev nodejs

WORKDIR $APP_PATH
COPY Gemfile $APP_PATH/Gemfile
COPY Gemfile.lock $APP_PATH/Gemfile.lock

RUN bundle install

COPY . $APP_PATH

ENV BUNDLE_PATH=/gems BUNDLE_JOBS=3 BUNDLE_APP_CONFIG=$APP_PATH/.bundle/

RUN mkdir -p $BUNDLE_PATH
RUN chown $UID $BUNDLE_PATH

VOLUME $BUNDLE_PATH

