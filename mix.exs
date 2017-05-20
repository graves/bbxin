defmodule Bbxin.Mixfile do
  use Mix.Project

  def project do
    [app: :bbxin,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [
      extra_applications: [:logger, :discord_ex],
      mod: {Bbxin, []}
    ]
  end

  defp deps do
    [
      {:discord_ex, git: "https://github.com/rmcafee/discord_ex.git", branch: "master"},
      {:xinscrape, git: "https://bitbucket.org/dg4l/xinscrape.git", branch: "master"},
      {:html_entities, "~> 0.3"}
    ]
  end
end
