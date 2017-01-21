defmodule YelpElixir.Client.Base do
  @moduledoc """
  Client implementation module.

  ## Example:

      client = YelpElixir.API.get_token!
      options = [params: [sort_by: "distance", longitude: -75.145101, latitude: 39.54364]]
      YelpElixir.Client.Base.get(client, "businesses/search", options)
  """

  alias YelpElixir.API

  @doc """
  Issues a GET request.
  """
  @spec get(%OAuth2.Client{}, String.t, Keyword.t) :: {:ok,  OAuth2.Response.t} | {:error, HTTPoison.Error.t}
  def get(client, endpoint, options \\ []) do
    headers = [auth: "#{client.token.token_type} #{client.token.access_token}"]

    API.request(:get, headers, endpoint, options)
  end

  @doc """
  Same as `get/3` but raises `HTTPoison.error` if an error occurs.
  """
  @spec get!(%OAuth2.Client{}, String.t, Keyword.t) ::  OAuth2.Response.t
  def get!(client, endpoint, options \\ []) do
    case get(client, endpoint, options) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end


end
