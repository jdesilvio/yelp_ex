defmodule YelpElixir.Client do
  @moduledoc """
  Client to interact with the Yelp API.
  """

  @doc """
  Issues a GET request.
  """
  @spec get(%OAuth2.Client{}, String.t, Keyword.t) :: {:ok, %{}} | {:error, HTTPoison.Error.t}
  def get(client, url, options \\ []) do
    query = url <> URI.encode_query(options)
    header = ["Authorization": "#{client.token.token_type} #{client.token.access_token}"]

    HTTPoison.get(query, header)
  end

  @doc """
  Same as get/3 but raises `HTTPoison.error` if an error occurs.
  """
  @spec get!(%OAuth2.Client{}, String.t, Keyword.t) :: %{}
  def get!(client, url, params) do
    case get(client, url, params) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Issues a GET request to the /businesses/search endpoint.

  GET https://api.yelp.com/v3/businesses/search

  This endpoint performs a search of businesses
  based on the options submitted.

  *Note:* A location option is mandatory. Either by passing
  the `location` or `latitude` and `longitude`.
  """
  @spec search(%OAuth2.Client{}, Keyword.t) :: {:ok, %{}} | {:error, HTTPoison.Error.t}
  def search(client, options \\ []) do
    url = "https://api.yelp.com/v3/businesses/search?"
    get(client, url, options)
  end

  @doc """
  Same as search/2 but raises `HTTPoison.error` if an error occurs.
  """
  @spec search!(%OAuth2.Client{}, Keyword.t) :: %{}
  def search!(client, options \\ []) do
    search(client, options)
  end

end
