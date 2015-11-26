# Rebaser
![Rebaser]
(http://i.imgur.com/7Sqj6v2.gif)

Rebaser rebases all open pull requests.

## Installation

Add this line to your application's Gemfile:

    gem 'rebaser'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rebaser

## Usage

To use Rebaser, just run `rebaser` in the directory of the target project. Rebaser will pull all open pull requests from Github, then proceed to rebase and force push up. Rebaser will abort the rebase if there are merge conflicts.

## Why?

When someone breaks master, all branches need to be rebased to include a fix. This lets a single person do it instead of waiting for a everyone to rebase their own branches.
