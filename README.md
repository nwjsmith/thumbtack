# Thumbtack

A [Pinboard API](https://pinboard.in/api) client that's as simple as Pinboard.

Home - http://github.com/nwjsmith/thumbtack
RDoc - http://docs.theinternate.com/thumbtack
Bugs - http://github.com/nwjsmith/thumbtack/issues

## Examples

``` ruby
client = Thumbtack::Client.new(user, token)

# the most recent time a bookmark was added, updated, or deleted
client.posts.update

# add a bookmark
client.posts.add('http://theinternate.com', 'The Internate')
client.posts.add('http://theinternate.com', 'The Internate', extended: 'The personal website of Nate Smith', tags: 'awesome essential')

# delete a bookmark
client.posts.delete('http://theinternate.com')

# bookmarks
client.posts.get(tag: 'webdev')
client.posts.get(url: 'http://www.pinboard.in')

# recent bookmarks
client.posts.recent

# dates with number of posts on each date
client.posts.dates(tag: 'argentina')

# all bookmarks in the user's account
client.posts.all

# popular and recommended tags for a url
client.posts.suggest('http://blog.com/')

# all tags with usage counts
client.tags.get

# delete a tag
client.tags.delete('api')

# rename tags
client.tags.rename('api', 'ehpeeay')

# user's secret RSS key
client.user.secret

# user's API token
client.user.api_token

# all notes
client.notes.list

# an individual note
client.notes('8e5d6964bb810e0050b0')
```

## Contributing

In order to run the tests, create a file with your authentication token into `test/auth_token.txt`. The token can be found on [your password settings page](https://pinboard.in/settings/password) in Pinboard. The file should look something like this:

```
maciej:D41D8CD98F00B204E980
```
