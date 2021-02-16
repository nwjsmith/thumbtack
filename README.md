# Thumbtack - The best Pinboard API client for Ruby

[![GitHub Actions badge](https://github.com/nwjsmith/thumbtack/workflows/Test/badge.svg)]
[![Codecov](https://codecov.io/gh/nwjsmith/thumbtack/branch/master/graph/badge.svg)](https://codecov.io/gh/nwjsmith/thumbtack)
[![Inline Docs](http://inch-ci.org/github/nwjsmith/thumbtack.svg?branch=master)](http://inch-ci.org/github/nwjsmith/thumbtack)

## Description

Thumbtack is a simple Ruby client for the [Pinboard API](https://pinboard.in/api).

There are other Pinboard API clients for Ruby, but there are a few things that set Thumbtack apart:

* **Zero dependencies**  
  Thumbtack requires only a few things from Ruby's standard library.
* **Clean and consistent API**  
  Required arguments in Pinboard's API are required arguments in Thumbtack's method calls. With only one exception, Thumbtack's API mirrors Pinboard's 1-to-1.
* **Client-side validation**  
  Pinboard has [clearly defined rules about data types](https://pinboard.in/api/#data) and Thumbtack enforces them.
* **Ruby-isms**  
  Use regular Ruby types and let Thumbtack convert it to parameters acceptable to Pinboard (i.e. use `true`/`false` instead of `'yes'`/`'no'`).
* **Documentation**  
  Thorough documentation of the usage and API is a top priority for Thumbtack. No question should be unanswered.

## Usage

Initialize a client with your Pinboard username and API token

``` ruby
client = Thumbtack::Client.new(username, token)
```

Fetch the most recent time a bookmark was added, updated, or deleted

``` ruby
update_time = client.posts.update
```

Add bookmarks

``` ruby
client.posts.add('http://theinternate.com', 'The Internate')
client.posts.add('http://theinternate.com', 'The Internate', extended: 'The personal website of Nate Smith', tags: ['awesome', 'essential'])
```

Delete them too

``` ruby
client.posts.delete('http://theinternate.com')
```

Retrieve bookmarks by tag or other filters

``` ruby
tagged_webdev = client.posts.get(tag: 'webdev')
tagged_webdev_and_ruby = client.posts.get(tag: ['webdev', 'ruby'])
pinboard_bookmark = client.posts.get(url: 'http://www.pinboard.in')
```

Fetch recently added bookmarks

``` ruby
recent_bookmarks = client.posts.recent
```

Get bookmark creation dates with a count of bookmarks created

``` ruby
dates_with_counts = client.posts.dates(tag: 'argentina')
```

Get every bookmark from the account

``` ruby
all_bookmarks = client.posts.all
```

Fetch popular and recommended tags for a URL

``` ruby
tag_suggestions = client.posts.suggest('http://blog.com/')
```

Find every tag with their usage count

``` ruby
tags_with_counts = client.tags.get
```

Remove tags

``` ruby
client.tags.delete('api')
```

Rename them

``` ruby
client.tags.rename('delicious', 'pinboard')
```

Get your secret RSS key

``` ruby
client.user.secret
```

Retrieve your API key

``` ruby
client.user.api_token
```

Fetch summaries of all notes (no text)

``` ruby
client.notes.list
```

Then fetch the full note

``` ruby
client.notes('8e5d6964bb810e0050b0')
```

## The one inconsistency between Thumbtack and Pinboard

Thumbtack tries hard to mimic the Pinboard API, *BUT*: Pinboard's notes have an attribute named `hash`. Unfortunately, this collides with a [special method in Ruby](http://ruby-doc.org/core-2.1.3/Object.html#method-i-hash). To work around this, Thumbtack renames the `hash` attribute to `digest` in the `Note` and `NoteSummary` objects returned from `Notes#list` and `Notes#get`.

## Requirements

* Ruby 2.3.6+, but you're already on 2.5+, right?
* Nothing else. No gem dependencies, nothing.

## Installation

The best way to install Thumbtack is with RubyGems:

```
$ [sudo] gem install thumbtack
```

## API Documentation

http://theinternate.com/thumbtack

## Contribute

If you'd like to make some changes to Thumbtack, start by forking the repo on GitHub:

http://github.com/nwjsmith/thumbtack

The best way to get contributions merged into Thumbtack:

1. Clone down your fork.
2. Create a well-named topic branch for your change
3. Make your change.
4. Add tests and make sure everything passes (see the section on running the tests below).
5. If you are adding new functionality, document it in the README.
6. Do not change the version number.
7. If necessary, rebase your commits into logical chunks, with no failing commits.
8. Push the branch to GitHub.
9. Send a pull request to the nwjsmith/thumbtack project.

## Run the tests

``` bash
$ bundle install

# Run only the unit tests (no communication/authentication with Pinboard)
$ bundle exec rake test:unit

# Run the full test suite (will communicate with Pinboard)
$ bundle exec rake test
```

**Note** to run the full test suite, copy and paste your [API Token](https://pinboard.in/settings/password) into the `test/auth_token.txt` file. It should look something like this:

``` text
maciej:C9044F4047891CEA74FE
```

## License

Thumbtack is released under the [MIT License](http://opensource.org/licenses/MIT).
