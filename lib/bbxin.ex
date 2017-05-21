defmodule Bbxin do
  @moduledoc """
  Ew.
  """

  use Application

  def start(_type, _opts) do
    import Supervisor.Spec, warn: false

    opts = Application.get_env(:bbxin, :discord_opts)
    username = Application.get_env(:bbxin, :username)

    children = [
      worker(DiscordEx.Client, [opts]),
      worker(Bbxin.Appropriator, [username])
    ]

    opts = [strategy: :one_for_one, name: Bbxin.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defdelegate randquote(server), to: Bbxin.Appropriator
end
