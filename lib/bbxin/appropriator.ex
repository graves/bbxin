defmodule Bbxin.Appropriator do
  @moduledoc """
  GenServer for holding Xintani quotes.
  """

  use GenServer

  # Public API

  @doc """
  Starts a Bbxin.Client GenServer

  ## Examples

  iex> Bbxin.Appropriator.start_link()
  {:ok, #PID<0.85.0>}

  """
  def start_link(username) do
    GenServer.start_link(__MODULE__, username, name: :"#{username}")
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
    {:ok, userquotes} = server
    |> quotes

    userquotes
    |> Enum.random
  end

  # Server callbacks

  def init(username) do
    quotes = get_user_quotes(0, username, [])
    {:ok, %{username: username, quotes: quotes}}
  end

  def handle_cast({:stash_quotes, quotes}, state) do
    {:noreply, Map.put(state, :quotes, quotes)}
  end

  def handle_call({:quotes}, _from, state) do
    {:reply, Map.fetch(state, :quotes), state}
  end

  def handle_cast({:pull_quotes}, state = %{username: username}) do
    quotes = get_user_quotes(0, username, [])
    {:noreply, Map.put(state, :quotes, quotes)}
  end

  defp get_user_quotes(offset, username, acc) do
    page_quotes = get_page(username, offset)
    case page_quotes do
      [] ->
        acc
      page_quotes ->
        acc = List.flatten([page_quotes | acc])
        increment(offset)
        |> get_user_quotes(username, acc)
    end
  end

  defp get_page(username, offset) do
    Xinscrape.all(username, offset)
    |> Xinscrape.Helpers.remove_html
    |> Xinscrape.Helpers.about_self
  end

  defp increment(offset) do
    offset + 30
  end
end
