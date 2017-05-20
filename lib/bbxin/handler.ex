defmodule Bbxin.Handler do
  @moduledoc """
  Listens for Xintani's wonderful beautiful name and replies
  with one of her rly funny and smart quotes from 6um.
  """
  require Logger

  alias DiscordEx.RestClient.Resources.Channel

  # Xintani Handler
  def handle_event({event, payload = %{data: data}}, state) do
    Logger.info "Received Event: #{event}"
    case contains_xintani(data["content"]) do
      true ->
        Logger.info("Talmbout Xin again :(")
        Channel.send_message(state[:rest_client], payload.data["channel_id"], %{content: Bbxin.randquote(:bbxin) |> HtmlEntities.decode})
      _ ->
        Logger.info("Talmbout anything else, ty <3")
    end

    {:ok, state}
  end

  # Fall through
  def handle_event({event, _payload}, state) do
    Logger.info "Received Event: #{event}"

    {:ok, state}
  end

  def contains_xintani(msg) do
    case msg do
      nil ->
        false
      _ ->
        Regex.match?(~r/.*xintani.*/i, msg)
    end
  end
end
