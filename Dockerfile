FROM ruby:3.2.1-slim

RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    less \
    git \
    libpq-dev \
    postgresql-client \
    libvips \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

RUN gem update --system && gem install bundler

# Set the working directory
WORKDIR /usr/src/app

# Copy the entrypoint script into the container and make it executable
COPY ./bin/docker-entrypoint.sh /usr/src/app/bin/
RUN chmod +x /usr/src/app/bin/docker-entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["./bin/docker-entrypoint.sh"]

# Expose the port the app runs on
EXPOSE 3000

# Start the main process
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
