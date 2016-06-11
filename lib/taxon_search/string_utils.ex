defmodule TaxonSearch.StringUtils do
  @moduledoc """
  Provides functions to help with tokenizing strings, generating regexes from
  string tokens, and matching phrases against sets of string tokens.

  A token is defined as a series of alphanumeric characters separated from other
  tokens by whitespace or punctuation.
  """

  @doc """
  Returns true if `str` matches against all of the `regexes`.

  ## Parameters

    - regexes: Collection of regular expressions
    - str: String to match against the `regexes`

  ## Examples

      iex> TaxonSearch.StringUtils.all_regexes_match?(["Hello", "world"], "Hello, world")
      true

      iex> TaxonSearch.StringUtils.all_regexes_match?(["Goodbye", "world"], "Hello, world")
      false
  """
  def all_regexes_match?(regexes, str) do
    Enum.all?(regexes, fn(regex) -> str =~ regex end)
  end

  @doc """
  Returns a collection of case-insensitive regexes, one for each token in `str`.

  ## Parameters

    - str: String to split into token regexes

  ## Examples

      iex> TaxonSearch.StringUtils.get_token_regexes("Red-headed monkey  ")
      [~r/Red/i, ~r/headed/i, ~r/monkey/i]
  """
  def get_token_regexes(str) do
    str |> get_string_tokens |> Enum.map(&get_token_regex/1)
  end

  @doc """
  Returns a collection of the tokens in `str`.

  ## Parameters

    - str: String to split into tokens

  ## Examples

      iex> TaxonSearch.StringUtils.get_string_tokens("Red-headed monkey  ")
      ["Red", "headed", "monkey"]
  """
  def get_string_tokens(str) do
    cleaned_str = str
                  |> String.replace(~r/\W+/, " ")
                  |> String.strip
    Regex.split(~r/\W+/, cleaned_str)
  end

  @doc """
  Returns a case-insenstive regular expression generated from `str`.

  ## Parameters

    - str: String to convert into a case-insensitive regular expression

  ## Examples

      iex> TaxonSearch.StringUtils.get_token_regex("Red")
      ~r/Red/i
  """
  def get_token_regex(str) do
    ~r/#{str}/i
  end
end
