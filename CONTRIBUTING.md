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


# Contributing to Moraga

We here at Moraga are open for all types of contributions from anyone. Tell us about our [issues/ideas](https://github.com/opensouthcode/moraga/issues/new), propose code changes via [pull requests](https://help.github.com/articles/using-pull-requests) or contribute artwork and documentation.


We need your input and contributions to Moraga. In particular we seek the following types:

* **code**: contribute your expertise in an area by helping us expand MORAGA with features/bugfixes/UX
* **code editing**: fix typos, clarify language, and generally improve the quality of the content of MORAGA
* **ideas**: participate in an issues thread or start your own to have your voice heard
* **translations**: translate Moraga into other languages than English

Read this guide on how to do that.

## How to contribute code

1. Fork the repository and make a pull-request with your changes
    1. Make sure that the test suite passes and that you comply to our code style
    1. Please increase code coverage with your pull request
1. One of the Moraga maintainers will review your pull-request
    1. If you are already a contributor and you get a positive review, you can merge your pull-request yourself
    1. If you are not already a contributor, one of the existing contributors will merge your pull-request

**However, please bear in mind the following things:**

### Discuss Large Changes in Advance

If you see a glaring flaw within Moraga, resist the urge to jump into the
code and make sweeping changes right away. We know it can be tempting, but
especially for large, structural changes it's a wiser choice to first discuss
them in the [issue list](https://github.com/opensouthcode/moraga/issues).

A good rule of thumb, of what a *structural change* is, is to estimate how much
time would be wasted if the pull request was rejected. If it's a couple of minutes
then you can probably dive head first and eat the loss in the worst case. Otherwise,
making a quick check with the other developers could save you lots of time down the line.

Why? It may turn out that someone is already working on this or that someone already
has tried to solve this and hit a roadblock, maybe there even is a good reason
why this particular flaw exists? If nothing else, a discussion of the change will
usually familiarize the reviewer with your proposed changes and streamline the
review process when you finally create a pull request.

### Small Commits & Pull Request Scope

A commit should contain a single logical change, the scope should be as small
as possible. And a pull request should only consist of the commits that you
need for your change. If it's possible for you to split larger changes into
smaller blocks please do so.

Why? Limiting the scope of commits/pull requests makes reviewing much easier.
Because it will usually mean each commit can be evaluated independently and a
smaller amount of commits per pull request usually also means a smaller amount
of code to be reviewed.

### Proper Commit Messages

We are keen on proper commit messages because they will help us to maintain
this code in the future. We define proper commit messages like this:

* The title of your commit message summarizes **what** has been done
* The body of your commit message explains **why** you have done this

If the title is too small to explain **what** you have done, then you can of course
elaborate about it in the body. Please avoid explaining *how* you have done this,
we are developers too and we see the diff, if we do not understand something we will
ask you in the review.

Additional to **what** and **why** you should explain potential **side-effects** of
this change, if you are aware of any.

## Development Environment

To isolate your host system from Moraga development we have prepared a container
based development environment, based on [docker](https://www.docker.com/) and
[docker-compose](https://docs.docker.com/compose/). Here's a step by step guide
how to set it up.

**WARNING**: Since we mount the repository into our container, your user id and
the id of the moraga user inside the container need to be the same. If your user
id (`id -u`) is something else than `1000` you can copy the docker-compose
override example file and in it, set your user id in the variable
*CONTAINER_USERID*.

```bash
sed "s/13042/`id -u`/" docker-compose.override.yml.example > docker-compose.override.yml
```

1. Build the development environment (only once)
   ```bash
   docker-compose build --no-cache --pull
   ```
1. Set up the development environment (only once)
   ```bash
   docker-compose run --rm moraga bundle exec rake db:bootstrap
   ```
1. Start the development environment:
   ```bash
   docker-compose up --build
   ```

1. Check out your Moraga rails app. You can access the app at http://localhost:3000. Whatever you change in your cloned repository will have effect in the development environment. Sign up, the first user will be automatically assigned the admin role.

1. Changed something? Run the tests to verify your changes!
   ```bash
   docker-compose run --rm moraga bundle exec rspec spec
   ```

1. Issue any standard `rails`/`rake`/`bundler` command
   ```bash
   docker-compose run --rm moraga bundle exec rake db:version
   ```

1. Or explore the development environment:
   ```bash
   docker-compose exec moraga /bin/bash -l
   ```

## How to contribute translations

Moraga uses Rails' I18n framework for internationalization. Translation files are located in `config/locales/` and organized by language code (e.g., `en.yml` for English, `es.yml` for Spanish). Each language has corresponding view-specific translation files in subdirectories like `config/locales/views/conferences/`, `config/locales/views/proposals/`, etc.

To contribute a new translation:
1. Create a new locale file following the pattern `config/locales/[language_code].yml` (e.g., `fr.yml` for French)
2. Create corresponding translation files for each view subdirectory (e.g., `config/locales/views/conferences/fr.yml`)
3. Use the English files as reference and translate all keys while maintaining the same YAML structure
4. Test your translations locally by setting `I18n.locale` in the Rails console
5. Submit a pull request with your translation files

For updates to existing translations, simply edit the corresponding locale files and submit a pull request with your changes.

## Code of Conduct

Moraga follow the Berlin Code of Conduct. More information in the website: https://berlincodeofconduct.org/

## Contact

GitHub issues and pull requests are the primary way for communicating about specific proposed
changes to this project.
