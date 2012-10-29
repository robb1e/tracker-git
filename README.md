# Tracker::Git

Update Pivotal Tracker depending on your local Git repository. 

This gem finds all finished stories and bugs and if it finds the story id in a Git commit, marks that story as delivery. 

This has proved useful as part of a 'deploy to staging' strategy. If you automatically deploy to a staging environment after a successful continuous integration build, and want to update a story from 'finished' to 'delivered', then this Gem is for you.

## CI

[![Build Status](https://secure.travis-ci.org/robb1e/tracker-git.png)](http://travis-ci.org/robb1e/tracker-git)

## Installation

Add this line to your application's Gemfile:

    gem 'tracker-git'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tracker-git

## Usage

This gem will create a 'tracker' binary. Call that in your deploy script with the following environment variables set, and your finished stories will be updated to delivered.

    export tracker_token=abc123
    export tracker_project_id=123456

## Known Issues

- [Restarting stories](https://github.com/robb1e/tracker-git/issues/1)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request