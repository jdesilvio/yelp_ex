defmodule YelpEx.Client do
  @moduledoc """
  Client to interact with Yelp's Fusion API.
  """

  use YelpEx.Client.Base

  @doc """
  Issues a GET request to the `/businesses/search` endpoint.

      GET https://api.yelp.com/v3/businesses/search

  This endpoint performs a search of businesses
  based on the options submitted.

  ## Options:

  * `:params` See Yelp
    [docs](https://www.yelp.com/developers/documentation/v3/business_search)
    for full list of `params`
  * For all other `options` see:
    [`HTTPoison.request/5`](https://hexdocs.pm/httpoison/0.10.0/HTTPoison.html#request/5)

  *Note:* A **location** option is mandatory. Either by passing
  the `location` or both the `latitude` and the `longitude`.

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
  Same as `search/1` but raises `HTTPoison.Error` if an error occurs.
  """
  @spec search!(Keyword.t) :: %{}
  def search!(options) do
    get!("businesses/search", [], options)
  end

  @doc """
  Issues a GET request to the `/businesses/search/phone`
  endpoint.

      GET https://api.yelp.com/v3/businesses/search/phone

  This endpoint performs a search of businesses
  based on a phone number.

  ## Options:

  * `:params` This endpoint takes one param, `phone`.
    The phone number of the business you want to search for
    as a string. It must start with + and include the
    country code. See Yelp
    [docs](https://www.yelp.com/developers/documentation/v3/business_search_phone)
    for more.
  * For all other `options` see:
    [`HTTPoison.request/5`](https://hexdocs.pm/httpoison/0.10.0/HTTPoison.html#request/5)

  ## Examples:

      iex> options = [params: [phone: "+14159083801"]]

      iex> YelpEx.Client.search_phone(options)
      {:ok, {<RESPONSE>}}

      iex> YelpEx.Client.search_phone!(options)
      {<RESPONSE>}

  """
  @spec search_phone(Keyword.t) :: {:ok, %{}} | {:error, HTTPoison.Error.t}
  def search_phone(options) do
    get("businesses/search/phone", [], options)
  end

  @doc """
  Same as `search_phone/1` but raises `HTTPoison.Error`
  if an error occurs.
  """
  @spec search_phone!(Keyword.t) :: %{}
  def search_phone!(options) do
    get!("businesses/search/phone", [], options)
  end

end
