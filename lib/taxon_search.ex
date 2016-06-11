defmodule TaxonSearch do
  alias TaxonSearch.Utils

  def get_species_name(common_name) do
    case get_result(common_name) do
      %{"species" => species} -> species
      _ -> nil
    end
  end

  defp get_result(common_name) do
    all_results = common_name
                  |> get_results
                  |> filter_by_name_type
    common_name_matches = filter_by_common_name(all_results, common_name)
    List.first(common_name_matches) || List.first(all_results)
  end

  defp filter_by_common_name(results, common_name) do
    Enum.filter results, fn(result) ->
      matching_common_name?(result, common_name)
    end
  end

  defp filter_by_name_type(results) do
    Enum.filter results, fn(result) ->
      result["nameType"] =~ ~r/scientific/i
    end
  end

  defp matching_common_name?(result, common_name) do
    name_maps = result["vernacularNames"] || []
    common_name_regexes = Utils.get_token_regexes(common_name)
    matching_english_name? = fn(name_map) ->
      name_map["language"] == "eng" &&
        Utils.all_regexes_match?(common_name_regexes, name_map["vernacularName"])
    end

    Enum.any?(name_maps, matching_english_name?)
  end

  defp get_results(common_name) do
    response = make_species_search_request(common_name)
    parsed_response_body = Poison.decode!(response.body)

    parsed_response_body["results"]
  end

  defp make_species_search_request(query) do
    query_str = URI.encode(query) <> URI.encode("&limit=#{search_limit}")
    request_url = api_url <> "/species/search?q=" <> query_str
    HTTPotion.get(request_url, [timeout: timeout_milliseconds])
  end

  defp api_url do
    "http://api.gbif.org/v1"
  end

  defp search_limit do
    50
  end

  defp timeout_milliseconds do
    10_000
  end
end
