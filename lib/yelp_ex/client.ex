defmodule YelpEx.Client do
  @moduledoc """
  Client to interact with the Yelp API.
  """

  use YelpEx.Client.Base

  @doc """
  Issues a GET request to the /businesses/search endpoint.

  GET https://api.yelp.com/v3/businesses/search

  This endpoint performs a search of businesses
  based on the options submitted.

  *Note:* A location option is mandatory. Either by passing
  the `location` or `latitude` and `longitude`.

  ## Examples:

      iex> options = [params: [location: "Philadelphia, PA 19106"]]
      iex> YelpEx.Client.search(options)
      {:ok, {<RESPONSE>}}

      iex> options = [params: [longitude: -75.145101, latitude: 39.54364]]
      iex> YelpEx.Client.search!(options)
      {<RESPONSE>}

  """
  @spec search(Keyword.t) :: {:ok, %{}} | {:error, HTTPoison.Error.t}
  def search(options) do
    get("businesses/search", [], options)
  end

  @doc """
  Same as `search/2` but raises `HTTPoison.error` if an error occurs.
  """
  @spec search!(Keyword.t) :: %{}
  def search!(options) do
    get!("businesses/search", [], options)
  end

end
