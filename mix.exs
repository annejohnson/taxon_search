defmodule TaxonSearch.Mixfile do
  use Mix.Project

  def project do
    [app: :taxon_search,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: [:logger, :httpotion]
    ]
  end

  defp deps do
    [
      {:httpotion, "~> 2.2.0"},
      {:poison, "~> 2.0"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev}
    ]
  end
end
