# TaxonSearch

TaxonSearch is a tool for looking up species names by common name in Elixir.

## Installation

1. Add taxon_search to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:taxon_search, "~> 0.0.1"}]
end
```

## Usage

```elixir
iex> TaxonSearch.get_species_names("Senegal parrot")
["Poicephalus senegalus", "Poicephalus versteri"]
```

[Go here](https://hexdocs.pm/taxon_search) for full documentation.
