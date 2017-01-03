defmodule YelpElixir.Endpoints.Search do
  @moduledoc """
  Search businesses.

  GET https://api.yelp.com/v3/businesses/search
  """

  @url "https://api.yelp.com/v3/businesses/search?"
  @location {39.954364,-75.145101}

  @doc """
  Makes a GET request to the search endpoint.

  Inputs:
   * client: In the form of `%OAuth.Client{}`
   * params: A map of valid parameters used by the Yelp API

   *Note:* A location is mandatory. Either by passing
   the `location` parameter or `latitude` and `longitude`
   parameters.
  """
  def get(client, params) do
    query = @url <> URI.encode_query(params)
    header = ["Authorization": "#{client.token.token_type} #{client.token.access_token}"]

    HTTPoison.get(query, header)
  end

  def get!(client, params) do
    case get(client, params) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

end
