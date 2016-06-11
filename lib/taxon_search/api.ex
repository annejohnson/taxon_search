defmodule TaxonSearch.Api do
  @moduledoc false

  def get_results(common_name, http_module \\ HTTPotion) do
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
