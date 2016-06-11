defmodule TaxonSearch do
  def get_species_name(common_name) do
    results = get_results(common_name)
    filtered_results = filter_by_common_name(results, common_name)
    result = List.first(filtered_results) || List.first(results)
    case result do
      %{"species" => species} -> species
      _ -> nil
    end
  end

  def filter_by_common_name(results, common_name) do
    Enum.filter(results, fn(result) ->
      matching_common_name?(result, common_name)
    end)
  end

  def matching_common_name?(result, common_name) do
    name_maps = result["vernacularNames"]
    common_name_regexes = Enum.map(
      Regex.split(~r/\W+/, common_name),
      fn(name_component) -> ~r/#{name_component}/i end
    )
    matching_english_name? = fn(name_map) ->
      name_map["language"] == "eng" &&
        Enum.all?(common_name_regexes, fn(name_regex) ->
          name_map["vernacularName"] =~ name_regex
        end)
    end

    length(name_maps) > 0 &&
      Enum.any?(name_maps, matching_english_name?)
  end

  def get_results(common_name) do
    Poison.decode!(
      make_species_search_request(common_name).body
    )["results"]
  end

  defp make_species_search_request(query) do
    query_str = URI.encode(query) <> URI.encode("&limit=#{search_limit}")
    request_url = api_url <> "/species/search?q=" <> query_str
    HTTPotion.get(request_url)
  end

  defp api_url do
    "http://api.gbif.org/v1"
  end

  defp search_limit do
    50
  end
end
