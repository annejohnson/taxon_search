defmodule TaxonSearchTest do
  use ExUnit.Case
  doctest TaxonSearch

  test "get_species_names" do
    assert(
      TaxonSearch.get_species_names("human") |> Enum.member?("Homo sapiens")
    )

    assert(
      TaxonSearch.get_species_names("scaly-headed pionus") |> Enum.member?("Pionus maximiliani")
    )

    assert(
      TaxonSearch.get_species_names("water buffalo") |> Enum.member?("Bubalus bubalis")
    )
  end
end
