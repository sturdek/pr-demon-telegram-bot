# pr-demon-telegram-bot

A telegram bot that listens to the WS of the pr-demon and broadcast the status of the test.

Details on pr-demon, please refer to https://github.com/lawliet89/pr_demon


## Getting started

Add a `docker_env` file at project root level (same level as Dockerfile). It looks like:

```
PRDEMON_WS=ws://prdemon_pr_demon_1:7999
TELEGRAM_TOKEN=[key_without_[]]
RECIPIENTS=[key_without_[]]
LRU_COUNT=10
```
Make sure you have `docker` and `docker-compose` installed.

Run `docker-compose up --build -d` at project root level.

## Config

You can use any broadcasters, just add the broadcaster to the telegram group and set your bot's token in `TELEGRAM_TOKEN`.

When you want to subscribe your telegram group to this bot,
you need to get your group's chat id and add it to `RECIPIENTS`.
`RECIPIENTS` is a string which will be split by '|'. Adding multiple recipients looks like this:
```
RECIPIENTS=7235478283|7235478281|7235478280
```

LRU_COUNT set the max size of the LRU Cache that will be use to store the state of the PR test


## TODO
Add rescue for Telegram::Bot::Exceptions::ResponseError
Send alert when bot goes down
