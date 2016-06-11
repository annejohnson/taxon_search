defmodule TaxonSearch do
  alias TaxonSearch.{StringUtils, Api}

  def get_species_names(common_name) do
    all_results = Api.get_results(common_name)
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
    StringUtils.get_token_regexes(name)
    |> StringUtils.all_regexes_match?(vernName)
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
end
