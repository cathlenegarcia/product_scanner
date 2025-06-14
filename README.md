# Product Scanner

A Ruby on Rails application for scanning and managing product information.

## Requirements

* Ruby version: See `.ruby-version` file
* Rails 8.0.0
* PostgreSQL
* Docker (optional, for containerized deployment)

## System Dependencies

* PostgreSQL database
* Node.js (for asset compilation)
* Yarn (for JavaScript dependencies)

## Configuration

1. Clone the repository
2. Install dependencies:
   ```bash
   bundle install
   ```
3. Set up the database:
   ```bash
   rails db:create db:migrate
   ```
4. Configure environment variables (if any)

## Development Setup

1. Start the Rails server:
   ```bash
   rails server
   ```
2. Visit `http://localhost:3000`

## Testing

The application uses RSpec for testing. Run the test suite with:

```bash
bundle exec rspec
```

## Key Features

* Product scanning and management
