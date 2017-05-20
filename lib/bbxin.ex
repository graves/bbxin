defmodule Bbxin do
  @moduledoc """
  Ew.
  """

  use Application

  def start(_type, _opts) do
    import Supervisor.Spec, warn: false

    opts = Application.get_env(:bbxin, :start_opts)

    children = [
      worker(Bbxin.Client, [opts])
    ]

    opts = [strategy: :one_for_one, name: Bbxin.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defdelegate start_link(opts), to: Bbxin.Client
  defdelegate randquote(server), to: Bbxin.Client
end
