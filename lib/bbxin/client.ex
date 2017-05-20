defmodule Bbxin.Client do
  @moduledoc """
  GenServer for holding our Discord Client PID
  and Xintani quotes.
  """

  use GenServer

  # Public API

  @doc """
  Starts a Bbxin.Client GenServer

  ## Examples

  iex> Bbxin.Client.start_link(%{token: "token", guild: "guild_id", channel: "channel_id"})
  {:ok, #PID<0.85.0>}

  """
  def start_link(%{token: token, guild: guild_id, channel: channel_id}) do
    {:ok, client} = DiscordEx.Client.start_link(%{
          token: token,
          guild_id: guild_id,
          channel_id: channel_id,
          handler: Bbxin.Handler
        })

    GenServer.start_link(__MODULE__, client, name: :bbxin)
  end

  def pull_quotes(server) do
    GenServer.cast(server, {:pull_quotes})
  end

  def stash_quotes(server, quotes) do
    GenServer.cast(server, {:stash_quotes, quotes})
  end

  def quotes(server) do
    GenServer.call(server, {:quotes})
  end

  def randquote(server) do
    {:ok, xinquotes} = server
    |> quotes

    xinquotes
    |> Enum.random
  end

  # Server callbacks

  def init(client) do
    quotes = get_xintani_quotes(0, [])
    {:ok, %{discord_client: client, quotes: quotes}}
  end

  def handle_cast({:stash_quotes, quotes}, state) do
    {:noreply, Map.put(state, :quotes, quotes)}
  end

  def handle_call({:quotes}, _from, state) do
    {:reply, Map.fetch(state, :quotes), state}
  end

  def handle_cast({:pull_quotes}, state) do
    quotes = get_xintani_quotes(0, [])
    {:noreply, Map.put(state, :quotes, quotes)}
  end

  defp get_xintani_quotes(offset, acc) do
    page_quotes = get_page(offset)
    case page_quotes do
      [] ->
        acc
      page_quotes ->
        acc = List.flatten([page_quotes | acc])
        increment(offset)
        |> get_xintani_quotes(acc)
    end
  end

  defp get_page(offset) do
    Xinscrape.all("xintani", offset)
    |> Xinscrape.Helpers.remove_html
    |> Xinscrape.Helpers.about_self
  end

  defp increment(offset) do
    offset + 30
  end
end
