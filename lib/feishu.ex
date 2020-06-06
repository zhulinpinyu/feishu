defmodule Feishu do
  @moduledoc """
  Documentation for `Feishu`.
  """

  @doc """
  发送消息, 默认富文本消息 post
  """
  defdelegate send(user_ids, params, type \\ "post"), to: Feishu.Message
end
