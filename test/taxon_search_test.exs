defmodule TaxonSearchTest do
  use ExUnit.Case
  doctest TaxonSearch

  test "get_species_name" do
    assert(
      TaxonSearch.get_species_name("scaly headed pionus") == "Pionus maximiliani"
    )

    assert(
      TaxonSearch.get_species_name("water buffalo") == "Bubalus bubalis"
    )
  end
end
