defmodule YelpElixir.Client do
  @moduledoc """
  Client to interact with the Yelp API.
  """

  alias YelpElixir.Client.Base

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
    endpoint = "businesses/search"
    Base.get(client, endpoint, options)
  end

  @doc """
  Same as `search/2` but raises `HTTPoison.error` if an error occurs.
  """
  @spec search!(%OAuth2.Client{}, Keyword.t) :: %{}
  def search!(client, options \\ []) do
    search(client, options)
  end

end
