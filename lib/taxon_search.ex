defmodule TaxonSearch do
  def get_species_name(common_name) do
    results = extract_results(make_species_search_request(common_name).body)
    hd(results)["species"]
  end

  defp extract_results(raw_response_body) do
    Poison.decode!(raw_response_body)["results"]
  end

  defp make_species_search_request(query) do
    request_url = api_url <> "/species/search?q=" <> URI.encode(query)
    HTTPotion.get(request_url)
  end

  defp api_url do
    "http://api.gbif.org/v1"
  end
end
