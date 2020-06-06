use Mix.Config

config :feishu,
  app_id: System.get_env("APP_ID"),
  app_secret: System.get_env("APP_SECRET")

config :tesla, :adapter, Tesla.Adapter.Mint
