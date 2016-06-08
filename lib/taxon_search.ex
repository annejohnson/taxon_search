defmodule TaxonSearch do
  def api_url do
    "https://api.opentreeoflife.org/v3"
  end

  def best_match(query) do
    result = hd(extract_results(make_match_names_request(query).body))
    best_match = hd(result["matches"])
    best_match["taxon"]["unique_name"]
  end

  def map_to_json_string(map) do
    Poison.encode!(map)
  end

  def extract_results(raw_response_body) do
    Poison.decode!(raw_response_body)["results"]
  end

  def make_match_names_request(query) do
    HTTPotion.post(
      api_url <> "/tnrs/match_names",
      headers ++ [
        body: map_to_json_string(%{ names: [query] })
      ]
    )
  end

  def headers do
    [headers: ["Content-Type": "application/json"]]
  end
end
