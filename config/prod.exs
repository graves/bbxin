use Mix.Config

config :bbxin, start_opts:
  %{
    token: System.get_env("BBXIN_TOKEN"),
    guild: System.get_env("BBXIN_GUILD"),
    channel: System.get_env("BBXIN_CHANNEL")
  }
