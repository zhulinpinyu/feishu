defmodule Feishu.Http do

  def post(path, body, headers) do
    headers
    |> middlewares()
    |> Tesla.client()
    |> Tesla.post(path, body)
    |> case do
      {:ok, %Tesla.Env{body: body, status: 200}} ->
        {:ok, body}
      {:ok, res} ->
        {:error, res}
      err -> err
    end
  end

  defp middlewares(headers) do
    [
      {Tesla.Middleware.BaseUrl, "https://open.feishu.cn"},
      {Tesla.Middleware.Headers, headers},
      {Tesla.Middleware.JSON, [engine_opts: [keys: :atoms]]}
    ]
  end
end
