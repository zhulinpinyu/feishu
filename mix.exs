defmodule Feishu.MixProject do
  use Mix.Project

  def project do
    [
      app: :feishu,
      version: "0.1.1",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      build_embedded: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Feishu",
      source_url: "https://github.com/zhulinpinyu/feishu"
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Feishu.Application, []}
    ]
  end

  defp description do
    "飞书(Feishu) for Elixir"
  end

  defp package do
    [
      files: ~w(lib .formatter.exs mix.exs README* config),
      maintainers: ["zhulinpinyu"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/zhulinpinyu/feishu"}
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:tesla, "~> 1.3"},
      {:jason, "~> 1.2"},
      {:mint, "~> 1.1"},
      {:castore, "~> 0.1"}
    ]
  end
end
