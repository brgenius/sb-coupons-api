defmodule SbCouponsApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :sb_coupons_api,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      preferred_cli_env: [espec: :test]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :maru, :httpotion],
      mod: {SbCouponsApi.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:envy, "~> 1.1.1"},
      {:ecto_sql, "~> 3.0"},
      {:ecto_soft_delete, "~> 1.0"},
      {:money, "~> 1.4"},
      {:postgrex, ">= 0.0.0"},
      {:nebulex_ecto, "~> 0.1"},
      {:espec, "~> 1.7.0", only: :test},
      {:maru, "~> 0.13"},
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.1"},
      {:httpotion, "~> 3.1.0"}
    ]
  end
end
