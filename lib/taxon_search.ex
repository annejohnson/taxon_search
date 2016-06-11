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
    get_unique_species_names(results_to_use)
  end

  defp get_unique_species_names(results) do
    Enum.map(results, &get_species_name/1)
    |> Enum.uniq
  end

  defp get_species_name(%{"species" => species}), do: species
  defp get_species_name(_), do: nil

  defp filter_by_common_name(results, common_name) do
    Enum.filter results, fn(result) ->
      matching_common_name?(result, common_name)
    end
  end

  defp matching_english_name?(%{"language" => "eng", "vernacularName" => vernName}, name) do
    Utils.get_token_regexes(name)
    |> Utils.all_regexes_match?(vernName)
  end
  defp matching_english_name?(_, _) do
    false
  end

  defp matching_common_name?(%{"vernacularNames": name_maps}, common_name) do
    Enum.any?(name_maps, fn(name_map) ->
      matching_english_name?(name_map, common_name)
    end)
  end
  defp matching_common_name?(_, _) do
    false
  end

  defp get_results(common_name, http_module) do
    response = make_species_search_request(common_name, http_module)
    parsed_response_body = Poison.decode!(response.body)

    parsed_response_body["results"]
  end

  defp make_species_search_request(query, http_module) do
    query_str = Map.merge(search_params, %{q: query})
                |> URI.encode_query
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
