[![Build Status](https://travis-ci.org/pivotal/pivotal-life.svg)](https://travis-ci.org/pivotal/pivotal-life) [![Dependency Status](https://gemnasium.com/pivotal/pivotal-life.svg)](https://gemnasium.com/pivotal/pivotal-life) [![Join the chat at https://gitter.im/pivotal/pivotal-life](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/pivotal/pivotal-life?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

# Pivotal Life

Pivotal Life is an information radiator for [Pivotal Labs](http://pivotallabs.com) offices. It shows information like the weather, public transportation schedules & status, upcoming office events, tweets and random Pivots.

For example, the NYC office dashboard can be viewed at <http://pivotal-life.cfapps.io/nyc>. You will need a username/password to log in. It can be retrieved using the `populate-dotenv.sh` script described below, which requires access to the `pivotallabs` organziation and `pivotal-life` space on [Pivotal Web Services](http://run.pivotal.io). To request access, email bkelly@pivotal.io or ask to be added by anyone who has access.

## Requirements

You will need the following to develop and run the dashboard locally:

- [Ruby](https://www.ruby-lang.org/en/)
- [Bundler](http://bundler.io/)
- [NodeJS](http://nodejs.org/) & [npm](https://www.npmjs.org/)
- [PhantomJS](http://phantomjs.org)
- [CloudFoundry Command-Line Interface](https://github.com/cloudfoundry/cli)

On Mac you can install NodeJs, PhantomJs and CloudFoundry with the following:

    $ brew install node
    $ brew install phantomjs
    $ brew tap pivotal/tap # Add pivotal tap if it's not already there
    $ brew install cloudfoundry-cli

## Setup

To checkout and run the project locally:

    $ git clone git@github.com:pivotal/pivotal-life.git
    $ cd pivotal-life
    $ bundle
    $ npm install -g coffee-script

### Environment Variables

To run the dashboard you will need a `.env` file with various tokens and keys.  The fastest way to do this is by pulling them down from Cloud Foundry.

First, target the pivotal-life app on the public Cloud Foundry deployment:

    $ cf api api.run.pivotal.io

Then log in to Cloud Foundry:
 
    $ cf login

If you belong to more than one org, select the `pivotallabs` org.

If you have acces to more than one space, select the `pivotal-life` space.

Next, build a `.env` file using the Cloud Foundry settings:

    $ ./populate-dotenv.sh

Several of the jobs need tokens and URLs that are in the `.env` file.

### Running

Now run the local server:
    
    $ bundle exec dashing start

Then navigate to <http://localhost:3030/> for the default dashboard or <http://localhost:3030/nyc> to see NYC's.
Log in to basic auth using the `AUTH_USERNAME` and `AUTH_PASSWORD` from the `.env` file.

## Adding an Office Dashboard

If you'd like to add your own office's dashboard, do the following:

1. Fork the project.
2. Under the `dashboards` directory, create an `.erb` template for your office.
3. Add any widgets that you'd like to make use of.
4. Any office specific data should be stored in `offices.yml` and can be read with the `Offices` and `Office` classes.
5. Run `rake` to run the tests pass.
6. Commit your code.
7. Make a pull request.
8. Once your pull requests is merged you'll see your changes on the [staging environment](http://pivotal-life-staging.cfapps.io/).

## Deploying

The application is automatically pushed to the [staging environment](http://pivotal-life-staging.cfapps.io/) once the build has passed on [Travis CI]((https://travis-ci.org/pivotal/pivotal-life)).

Once you've checked your changes on the staging environment, you can push to Production by doing the following

    $ cf push pivotal-life

Navigate to <http://pivotal-life.cfapps.io/>

## Resources

- [Pivotal Tracker Project](https://www.pivotaltracker.com/s/projects/950406)
- [Dashing](http://shopify.github.com/dashing)
- PM: Michael McGinley

