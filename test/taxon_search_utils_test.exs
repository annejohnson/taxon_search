defmodule TaxonSearchUtilsTest do
  use ExUnit.Case
  doctest TaxonSearch.Utils

  test "all_regexes_match?" do
    regexes = [~r/maximilian/, ~r/pionus/, ~r/parrot/]
    assert(
      TaxonSearch.Utils.all_regexes_match?(regexes, "maximilian pionus parrot")
    )
    refute(
      TaxonSearch.Utils.all_regexes_match?(regexes, "maximilian pionus bird")
    )
  end

  test "get_string_tokens" do
    assert(
      ["scaly", "headed", "pionus"] == TaxonSearch.Utils.get_string_tokens("scaly-headed pionus  ")
    )
  end
end
