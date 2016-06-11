defmodule TaxonSearch.Utils do
  def get_token_regexes(str) do
    str |> get_string_tokens |> Enum.map(&get_token_regex/1)
  end

  def all_regexes_match?(regexes, str) do
    Enum.all?(regexes, fn(regex) -> str =~ regex end)
  end

  def get_string_tokens(str) do
    Regex.split(~r/\W+/, str)
  end

  def get_token_regex(str) do
    ~r/#{str}/i
  end
end
