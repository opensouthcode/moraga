# Install for development

Moraga is a [Ruby on Rails0](https://rubyonrails.org/) web application, so if want to hack and contribute to Moraga, you need ruby installed.

The easy way is to use [RVM](https://rvm.io). After install `rvm` you can install the version of ruby that Moraga use (currently 3.1.4) with:

```
rvm install 3.1.4
```

After install ruby (you would need to close and open the terminal in order the rvm scripts to work), you need to install some libraries for the gems used by moraga get installed. In a debian/ubuntu system:

```
sudo apt install libmysql-dev
sudo apt install libpq-dev
sudo apt install nodejs
``` 

Next, you can install the gems:

```
bundle
```

## Create the db

Create and grant permission for one user to localhost.

## Configure moraga

Copy the `dotenv.example` to `.env` and configure with your database settings


## Run migrations

And last, run the migrations:

```
rails db:migrate
```

You then can run the application with:

```
rails s
```

and point your browser to http://localhost:3000 to see your new Moraga dev.


# Install for Production

Here is what you need to install MORAGA for production usage.

# 💥💥💥 WARNING 💥💥💥

![explosions](https://media.giphy.com/media/Yl5aO3gdVfsQ0/giphy.gif)

MORAGA is a Ruby on Rails server application for professional use, not some desktop app you run for yourself. If you deploy it, **YOU** are responsible for the data that users enter into it, this data includes personal information like email addresses and/or passwords that most likely can be used to harm them in some form (cracking, doxing, social engineering).

If you never deployed a Ruby on Rails app before we **strongly** suggest you seek help from someone who has. That someone is **NOT** the MORAGA team so please do **NOT** open an issue expecting us to explain how to do this.

*You should know what you do and you have been warned*.

## Versions

MORAGA is an [semantic versioned](http://semver.org/) app. That means given a version number MAJOR.MINOR.PATCH we increment the:

1. MAJOR version when we make incompatible changes,
2. MINOR version when we add functionality in a backwards-compatible manner
3. PATCH version when we make backwards-compatible bug fixes

## Download

You can find the latest MORAGA releases on our [release page](https://github.com/opensouthcode/moraga/releases)

## Deploy to the cloud

The easiest way to deploy MORAGA is to use one of the many platform as a service providers that support ruby on rails. We have prepared MORAGA to be used with [heroku](https://heroku.com). So if you have an account there, you can deploy MORAGA by pressing this button:

<a href="https://heroku.com/deploy?template=https://github.com/openSUSE/osem/tree/v1.0">
  <img src="https://www.herokucdn.com/deploy/button.svg" alt="Deploy">
</a>

## Deploy to your own server

We recommend to run MORAGA in production with [mod\_passenger](https://www.phusionpassenger.com/download/#open_source)
and the [apache web-server](https://www.apache.org/). There are tons of guides on how to deploy rails apps on various
base operating systems. [Check Google](https://encrypted.google.com/search?hl=en&q=ruby%20on%20rails%20apache%20passenger). Of course there are also other options for the application server and reverse proxy, pick your poison.

## Deploy via docker/docker-compose

There is a rudimentary docker-compose configuration for production usage (`docker-compose.yml.production-example`). It brings [MORAGA up](http://0.0.0.0:8080) on port 8080. It uses persistent storage volumes for all the data users might create. You can start it with

1. Configure MORAGA (at least `SECRET_KEY_BASE`)
   ```
   cp dotenv.example .env.production
   vim .env.production
   ```
1. Build the container image (every time you change code or config)
   ```
   docker-compose -f docker-compose.yml.production-example build
   ```
1. Setup the database (only once)
   ```
   docker-compose -f docker-compose.yml.production-example run --rm production_web bundle exec rake db:bootstrap
   ```
1. Start the services
   ```
   docker-compose -f docker-compose.yml.production-example up
   ```

## Configuration
MORAGA is configured through environment variables and falls back to sensible defaults. See the [dotenv.example](https://github.com/opensouthcode/moraga/blob/master/dotenv.example) for all possible configuration options. However here is a list of things you most likely want to configure because otherwise things will not work as expected.

### `SECRET_KEY_BASE`
A [random string](https://www.randomlists.com/string?base=16&length=64&qty=1) to encrypt sessions/cookies.

### `MORAGA_NAME`
The name of your MORAGA installation

### How to send emails
By default MORAGA tries to send emails over localhost.

#### `MORAGA_HOSTNAME`
The host this MORAGA instance runs on. This is used for generating URLs in emails sent.

#### `MORAGA_EMAIL_ADDRESS`
The address MORAGA uses to sending mails from.

#### `MORAGA_SMTP_ADDRESS`
The mail server we send mail over. (*default*: localhost)

#### `MORAGA_SMTP_AUTHENTICATION`
If your mail server requires authentication, you need to specify the authentication type here. This is a symbol and one of :plain (will send the password in the clear), :login (will send password Base64 encoded) or :cram_md5 (combines a Challenge/Response mechanism to exchange information and a cryptographic Message Digest 5 algorithm to hash important information)

#### `MORAGA_SMTP_USERNAME`
If your mail server requires authentication, set the username in this setting.

#### `MORAGA_SMTP_PASSWORD`
If your mail server requires authentication, set the password in this setting.
