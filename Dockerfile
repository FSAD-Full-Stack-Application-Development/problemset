# Use official Ruby image
FROM ruby:3.4.5
# Install dependencies
RUN apt-get update -qq && apt-get install -y \
    nodejs \
    postgresql-client \
    build-essential \
    libpq-dev \
    chromium \
    fonts-liberation \
    libnss3 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libxss1 \
    libasound2 \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libxshmfence1 \
    ca-certificates \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*



# Set working directory
WORKDIR /myapp
# Copy Gemfile and Gemfile.lock first
COPY Gemfile Gemfile.lock ./
# Install gems
RUN gem install bundler
RUN bundle install
# Copy the rest of the app
COPY . .
# Expose port
EXPOSE 3000
# Start Rails server
CMD ["bin/rails", "server", "-b", "0.0.0.0"]

