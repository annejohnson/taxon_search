defmodule TaxonSearchTest do
  use ExUnit.Case
  doctest TaxonSearch

  test "get_species_name" do
    assert(
      TaxonSearch.get_species_name("maximilian pionus") == "Pionus maximiliani"
    )
  end
end
