defmodule TaxonSearch.Mixfile do
  use Mix.Project

  def project do
    [app: :taxon_search,
     version: "0.0.1",
     description: description,
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     package: package]
  end

  def application do
    [applications: [:logger, :httpotion]]
  end

  defp description do
    "TaxonSearch is a tool for looking up species names in Elixir."
  end

  defp package do
    [licenses: ["MIT"],
     maintainers: ["annecodes@gmail.com"],
     links: %{"GitHub" => "https://github.com/annejohnson/taxon_search"}]
  end

  defp deps do
    [{:httpotion, "~> 2.2.0"},
     {:poison, "~> 2.0"},
     {:earmark, "~> 0.1", only: :dev},
     {:ex_doc, "~> 0.11", only: :dev}]
  end
end
