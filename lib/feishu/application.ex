defmodule Feishu.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Feishu.TokenServer
    ]

    opts = [strategy: :one_for_one, name: Feishu.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
