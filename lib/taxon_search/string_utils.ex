defmodule TaxonSearch.StringUtils do
  def all_regexes_match?(regexes, str) do
    Enum.all?(regexes, fn(regex) -> str =~ regex end)
  end

  def get_token_regexes(str) do
    str |> get_string_tokens |> Enum.map(&get_token_regex/1)
  end

  def get_string_tokens(str) do
    cleaned_str = str
                  |> String.replace(~r/\W+/, " ")
                  |> String.strip
    Regex.split(~r/\W+/, cleaned_str)
  end

  def get_token_regex(str) do
    ~r/#{str}/i
  end
end
