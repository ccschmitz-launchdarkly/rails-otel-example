FROM mcr.microsoft.com/devcontainers/ruby:2.7

# Install packages needed for gems like pg, nokogiri, etc.
RUN apt-get update \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get -y install --no-install-recommends \
    build-essential \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    git \
    shared-mime-info \
 && rm -rf /var/lib/apt/lists/*

# Node for ExecJS (Rails asset pipeline)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
 && apt-get update \
 && apt-get install -y nodejs \
 && rm -rf /var/lib/apt/lists/*

# Ensure bundler version from Gemfile.lock
RUN gem install bundler -v 2.4.22

WORKDIR /workspaces/rails-otel-example


