# Bbxin

Discord bot for narcisists who post on [DigitalGangster](https://6um.digitalgangster.com)

## Installation

The package can be installed by adding `bbxin` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:bbxin, "~> 0.1.0", git: "https://bitbucket.org/dg4l/bbxin", branch: "master"}]
end
```

## Spin up your own Discord bot using Docker

Install [Docker](https://www.docker.com/get-docker) on your platform of choice.

[Create a new Discord app.](https://discordapp.com/developers/docs/intro) You do not need a callback url.

Click the button to add a bot after creation.

Copy the bot's token from your app control panel and pass it to the docker container's environment using the `BBXIN_TOKEN` variable as seen below.

The `BBXIN_USERNAME` environment variable should contain the username of a member of [6um.](https://6um.digitalgangster.com)

The `BBXIN_NAMES` variable should be a comma seperated list of words you wish to trigger the bot's responses.
```
git clone https://bitbucket.org/dg4l/bbxin
cd bbxin
docker build . -t bbxin
docker run -it --rm -e BBXIN_TOKEN="yourDiscordBotToken" \
  -e BBXIN_USERNAME="xintani" \
  -e BBXIN_NAMES="xintani,rapGameMichelleBachmann,queenBeeNiceToDougiePls" \
  bbxin iex -S mix
```
Now that your bot is up and running copy the client id and [use it to create a url people can use to add your bot to their servers.](https://discordapp.com/developers/docs/topics/oauth2#adding-bots-to-guilds)

The URL should look as follows:

https://discordapp.com/api/oauth2/authorize?client_id=**yourAppsClientIdHere**&scope=bot&permissions=0
