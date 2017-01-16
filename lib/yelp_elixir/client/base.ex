defmodule YelpElixir.Client.Base do
  @moduledoc """
  Client implementation module.

  ## Example:

      client = YelpElixir.API.get_token!
      options = [params: [sort_by: "distance", longitude: -75.145101, latitude: 39.54364]]
      YelpElixir.Client.Base.get(client, options)
  """

  use HTTPoison.Base

  @url "https://api.yelp.com/v3/businesses/search?"

  @doc """
  Issues a GET request.
  """
  @spec get(%OAuth2.Client{}, Keyword.t) :: {:ok, %{}} | {:error, HTTPoison.Error.t}
  def get(client, options \\ []) do
    headers = [auth: "#{client.token.token_type} #{client.token.access_token}"]

    request(:get, headers, options)
  end

  @doc """
  Same as get/3 but raises `HTTPoison.error` if an error occurs.
  """
  @spec get!(%OAuth2.Client{}, Keyword.t) :: %{}
  def get!(client, options \\ []) do
    case get(client, options) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Perform an HTTP request.
  """
  def request(method, headers, options) do
    {auth, headers} = Keyword.pop(headers, :auth)
    auth_header = ["Authorization": auth]

    request(method, @url, "", auth_header, options)
  end

end
