defmodule TaxonSearch do
  alias TaxonSearch.Utils

  def get_species_names(common_name, http_module \\ HTTPotion) do
    all_results = get_results(common_name, http_module)
    filtered_results = filter_by_common_name(all_results, common_name)
    results_to_use = if Enum.empty?(filtered_results) do
                       all_results
                     else
                       filtered_results
                     end
    Enum.map(results_to_use, fn(result) -> result["species"] end)
    |> Enum.uniq
  end

  defp filter_by_common_name(results, common_name) do
    Enum.filter results, fn(result) ->
      matching_common_name?(result, common_name)
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

  defp get_results(common_name, http_module) do
    response = make_species_search_request(common_name, http_module)
    parsed_response_body = Poison.decode!(response.body)

    parsed_response_body["results"]
  end

  defp make_species_search_request(query, http_module) do
    query_str = Map.merge(search_params, %{q: query}) |> URI.encode_query
    request_url = api_url <> "/species/search?" <> query_str
    http_module.get(request_url, [timeout: timeout_milliseconds])
  end

  defp api_url do
    "http://api.gbif.org/v1"
  end

  defp search_params do
    %{limit: 50, nameType: "SCIENTIFIC", rank: "SPECIES", status: "ACCEPTED"}
  end

  defp timeout_milliseconds do
    10_000
  end
end
