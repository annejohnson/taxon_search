defmodule TaxonSearchTest do
  use ExUnit.Case
  doctest TaxonSearch

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "best match" do
    assert TaxonSearch.best_match("barraband") == "polytelis"
  end
end
