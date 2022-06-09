# Ruby on Rails Tutorial sample application

This is the sample application for<br>
[*Ruby on Rails Tutorial: Learn Web Development with Rails*](https://www.railstutorial.org/) (6th Edition)
by [Michael Hartl](https://www.michaelhartl.com/).

You can check the site following this link:
https://ikael.herokuapp.com

## Getting started
To get started with the app, clone the repo and then install the needed gems:
```
$ bundle install --without production
```
Next, migrate the database:
```
$ rails db:migrate
```
Finally, run the test suite to verify that everything is working correctly:
```
$ rails test
```
If the test suite passes, you'll be ready to run the app in a local server:
```
$ rails server
```
If you have `docker` and `docker-compose` installed on your system,
you can just run:
```
$ docker-compose run -d
```
You actually don't need to run `postgres container`.<br>
Application runs in development mode and uses `sqlite3
database` installed inside the container.<br>
So you can just run:
```
$ docker-compose run --rm -d -p 3000:3000 web
```
