defmodule Feishu.Message do
  def send(user_ids, %{} = params, type) when is_list(user_ids) do
    for user_id <- user_ids do
      body = %{
        user_id: user_id,
        msg_type: type,
        content: content(type, params)
      }
      Feishu.Http.post(msg_send_path(), body, headers())
    end
  end

  def send(user_id, %{} = params, type) do
    send([user_id], %{} = params, type)
  end

  defp content("text", %{content: content}), do: content
  defp content("post", %{title: title, contents: contents}) do
    %{
      post: %{
        zh_cn: %{
          title: title,
          content: Enum.map(contents, fn content ->
            [
              %{
                tag: "text",
                text: content
              }
            ]
          end)
        }
      }
    }
  end

  defp headers do
    [{"Authorization", "Bearer #{Feishu.TokenServer.tenant_access_token()}"}]
  end

  defp msg_send_path do
    "/open-apis/message/v4/send/"
  end
end
