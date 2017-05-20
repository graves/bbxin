defmodule BbxinTest do
  use ExUnit.Case
  doctest Bbxin

  @token "MzE0OTc2NzczMDM5MzI1MTg0.DAAg-w.X79DewfXPy2ehZ2xOJt_AQ0qx7o"

  test "bbxin can prove she hear me" do
    Bbxin.start(@token)
    #|> Bbxin.listen(%{guild: @guild, channel: @channel})
    #|> Bbxin.say("i'm sad and mean")
  end
end
