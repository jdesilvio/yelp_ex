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
   * term: Search term (optional)

  `get/1` returns the closest businesses.
  `get/2` returns the closest businesses that match the given search term.
  """
  #TODO Pass params as a keyword list
  def get(client) do
    url = @url |> inject_location(@location)
    header = ["Authorization": "#{client.token.token_type} #{client.token.access_token}"]

    HTTPoison.get(url, header)
  end

  def get!(client) do
    case get(client) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  def get(client, term) do
    url = (@url <> "?term=#{term}&") |> inject_location(@location)
    header = ["Authorization": "#{client.token.token_type} #{client.token.access_token}"]

    HTTPoison.get(url, header)
  end

  def get!(client, term) do
    case get(client, term) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  defp inject_location(url, location) do
    lat = Float.to_string(elem(location, 0))
    long = Float.to_string(elem(location, 1))

    url <> "latitude=#{lat}&longitude=#{long}"
  end

end
