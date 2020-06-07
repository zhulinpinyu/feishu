defmodule Feishu do
  @moduledoc """
  Documentation for `Feishu`.
  """

  @doc """
  发送消息, 默认富文本消息 post
  who is string or list
  """
  defdelegate send(who, params, type \\ "post"), to: Feishu.Message
end
