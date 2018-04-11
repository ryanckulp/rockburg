# Rockburg
Rockburg is a music industry simulation game that I've had brewing in my ([@Shpigford](https://twitter.com/Shpigford)) head for years.

Back in the early 2000's I was super in to this game called Project Rockstar and it met an untimely death thanks to trademark issues with their name. Poor guys.

Ultimately what I'm trying to do here is build a fun, modern simulation game. I have no idea what I'm doing, so all input is more than welcome!

## Codebase
The current codebase is vanilla Rails. Really nothing out of the ordinary here. Locally it's using SQLite locally for the data store and Sidekiq for workers.

```bash
$ bundle && rake db:migrate && rake db:seed # creates genres, venues, etc
$ mysql.server start
$ rails s

# in another console tab...
$ redis-server # required for db 'write' actions
```

## Contributing
It's still very early days for this. It doesn't exist on any public servers yet...all dev work is still just local. So, your mileage will vary here and lots of things will break.

But almost any contribution will be beneficial at this point as all the work I've done has been sledgehammer type stuff instead of details.

If you've got an improvement, just send in a pull request. If you've got feature ideas, simply [open a new issues](https://github.com/withspectrum/spectrum/issues/new)!

## License & Copyright
Released under the MIT license, see the [LICENSE](./LICENSE) file. Copyright (c) 2018 Sabotage Media LLC.
