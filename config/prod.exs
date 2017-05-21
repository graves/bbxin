use Mix.Config

config :bbxin, [
  discord_opts: %{
    token: System.get_env("BBXIN_TOKEN"),
    guild: System.get_env("BBXIN_GUILD") || "",
    channel: System.get_env("BBXIN_CHANNEL") || "",
    handler: Bbxin.Handler
  },
  username: System.get_env("BBXIN_USERNAME"),
  names: System.get_env("BBXIN_NAMES") |> String.split(",")
]
