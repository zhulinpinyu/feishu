defmodule Feishu.TokenServer do
  use GenServer

  @server __MODULE__

  def start_link(_) do
    GenServer.start(@server, :ok, name: @server)
  end

  def tenant_access_token do
    GenServer.call(@server, :tenant)
  end

  #Server

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call(:tenant, _from, state) do
    case lookup(state[:tenant]) do
      nil ->
        %{tenant: %{token: token}} = state = set_token()
        {:reply, token, state}
      token ->
        {:reply, token, state}
    end
  end

  defp lookup(nil), do: nil
  defp lookup(%{token: token, expired_at: expired_at} )do
    case DateTime.utc_now() < expired_at do
      true -> token
      _ -> nil
    end
  end

  def set_token() do
    body = %{
      app_id: Application.get_env(:feishu, :app_id),
      app_secret: Application.get_env(:feishu, :app_secret)
    }

    tenant_access_token_path()
    |> Feishu.Http.post(body, [{"Content-Type", "application/json"}])
    |> case  do
      {:ok, %{code: 0, expire: expire, tenant_access_token: token}} ->
        %{
          tenant: %{
            expired_at: DateTime.add(DateTime.utc_now(), expire),
            token: token
          }
        }
      _ -> %{}
    end
  end

  defp tenant_access_token_path, do: "/open-apis/auth/v3/tenant_access_token/internal/"
end
