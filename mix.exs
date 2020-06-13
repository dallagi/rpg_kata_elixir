defmodule RpgKata.MixProject do
  use Mix.Project

  def project do
    [
      app: :rpg_kata,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:elixir_uuid, "~> 1.2"}
    ] ++ dev_deps()
  end

  defp dev_deps do
    [
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false}
    ]
  end
end
