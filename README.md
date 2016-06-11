# TaxonSearch [![Hex.pm](https://img.shields.io/hexpm/v/taxon_search.svg?style=flat-square)](https://hex.pm/packages/taxon_search)

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

[View full documentation here.](https://hexdocs.pm/taxon_search)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/annejohnson/taxon_search. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
