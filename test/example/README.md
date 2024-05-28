# README

## Getting Started

- You need Postgres running, eg. with https://postgresapp.com/
- `cp .env.example .env` # Copy the example environment file and add your secrets.
- `rbenv install 3.3.0` # Install Ruby with rbenv
- `bundle install` # Install the gems.
- `brew install redis` # Install Redis for the background job queue.
- `redis-server` # Run Redis to store the job queue.

- `bin/rails db:create` # Create the database.
- `bin/rails db:migrate` # Migrate the database.
- `bin/dev` # Run the server.
- `standardrb --fix` # Run linter & auto-fix where possible.

## Set up Google Sign In with Omniauth

- Go to the [Google Cloud Console](https://console.cloud.google.com/)
- Click the dropdown at the top of the page and select "NEW PROJECT". Enter a project name and click "CREATE".
- Once it's created, click "SELECT PROJECT"
- At the top, search for "OAuth" and click "OAuth consent screen"
- Choose External and click CREATE.
- Fill in the form with your app's name, user support email, and developer contact information. You can leave the rest blank for now.
- Click SAVE AND CONTINUE.
- Click Credentials in the left sidebar and click CREATE CREDENTIALS.
- Choose OAuth client ID.
- For Application Type, choose Web application.
- Set the Name to your app's name.
- Under Authorized redirect URIs, add the following URI: http://localhost:3000/users/auth/google_oauth2/callback
- If you're deploying to production, you'll also need to add your app's domain as another URI with the same format: http://yourwebsite.com/users/auth/google_oauth2/callback
- Click CREATE.
- Set the Google Client ID and Secret in your .env file:

```
GOOGLE_OAUTH_CLIENT_ID=Your client id
GOOGLE_OAUTH_CLIENT_SECRET=Your client secret
```

## Pipelines 

Pipelines let you make a sequence of Assistants. Each message is passed to each assistant so they can give their response.

### Video Demo

You can find a short Loom demo of this feature [here](https://www.loom.com/share/4c1f0b763c544cbab415aa0d41d159d8?sid=64bb3fcd-c172-47b5-ba68-be77f5545ffb)

### Architecture

Here's a quick diagram of the LandingBurn Pipeline architecture.

<img src="https://github.com/landingburn-ai/landingburn/assets/7175262/7775631e-8c1d-484e-b909-c69f32488148" width="50%">

## Tests

Run the tests with `rspec`.

## Debugging

Add a breakpoint with `debugger`. To debug the server, you need to remove `web: bin/rails server` from `Procfile.dev`, and then run `bin/dev` in one terminal tab and `bin/rails s` in another one, then you can use `debugger` breakpoints in the `bin/rails s` tab.

### VCR

LandingBurn uses VCR to record HTTP requests and responses. To run a test against a live API and re-record a cassette:

```
VCR=all rspec spec/requests/assistants_spec.rb:13
```

## To add libraries using ImportMaps

- Like this: `./bin/importmap pin alpinejs`

## Admin

- `http://localhost:3000/sidekiq` # Monitor queued jobs.

## Why .env rather than credentials?

- Makes it easier to manage for others using the template.
- I generally prefer to keep credentials out of the codebase, even encrypted.
