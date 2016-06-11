defmodule TaxonSearchStringUtilsTest do
  use ExUnit.Case
  doctest TaxonSearch.StringUtils

  test "all_regexes_match?" do
    regexes = [~r/maximilian/, ~r/pionus/, ~r/parrot/]
    assert(
      TaxonSearch.StringUtils.all_regexes_match?(regexes, "maximilian pionus parrot")
    )
    refute(
      TaxonSearch.StringUtils.all_regexes_match?(regexes, "maximilian pionus bird")
    )
  end

  test "get_string_tokens" do
    assert(
      ["scaly", "headed", "pionus"] == TaxonSearch.StringUtils.get_string_tokens("scaly-headed pionus  ")
    )
  end
end
