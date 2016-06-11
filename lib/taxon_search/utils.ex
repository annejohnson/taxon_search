defmodule TaxonSearch.Utils do
  def get_token_regexes(str) do
    Enum.map(
      Regex.split(~r/\W+/, str),
      fn(str_token) -> ~r/#{str_token}/i end
    )
  end

  def all_regexes_match?(regexes, str) do
    Enum.all?(regexes, fn(regex) ->
      str =~ regex
    end)
  end
end
