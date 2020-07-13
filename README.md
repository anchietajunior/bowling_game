# Bowling Game

## Clone

```
git clone git@github.com:anchietajunior/bowling_game.git
```

## Install, create and migrate

```
bundle install
rails db:create && rails db:migrate
```

## Run

```
rails s
```

## Test

```
bundle exec rspec
```


# Routes

## Create a new game - POST

```
/game
```

## Status about the game - GET

This is the route the front should consume after each 2 seconds

```
/game/:id
```

## Create new Attempt - POST

```
/attempts
```