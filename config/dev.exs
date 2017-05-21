use Mix.Config

config :bbxin, [
  discord_opts: %{
    token: System.get_env("BBXIN_TOKEN"),
    guild: System.get_env("BBXIN_GUILD"),
    channel: System.get_env("BBXIN_CHANNEL"),
    handler: Bbxin.Handler
  },
  username: "xintani",
  names: ["xintani", "xin", "xinxin"]
]
