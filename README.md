# TaxonSearch

TaxonSearch is a tool for looking up species names by common name in Elixir.

## Installation

1. Add taxon_search to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:taxon_search, "~> 0.0.1"}]
end
```

2. Ensure taxon_search is started before your application:

```elixir
def application do
  [applications: [:taxon_search]]
end
```
