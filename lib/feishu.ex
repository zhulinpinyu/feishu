defmodule Feishu do
  @moduledoc """
  Documentation for `Feishu`.
  """

  @doc """
  send text message to somebody
  """
  defdelegate send(who, params, type \\ "post"), to: Feishu.Message
end
