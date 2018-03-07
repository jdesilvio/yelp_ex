defmodule YelpEx.API do
  @moduledoc """
  Yelp Fusion API wrapper for Elixir.

  Provides functionality to work with the Yelp Fusion API.
  """

  use HTTPoison.Base

  @api_url "https://api.yelp.com/v3/"

  @doc """
  Issues an HTTP request.
  """
  @spec request(atom, String.t, body, headers, Keyword.t) :: {:ok, HTTPoison.Response.t} | {:error, HTTPoison.Error.t}
  def request(method, endpoint, body \\ "", headers, options \\ []) do
    url = @api_url <> endpoint

    super(method, url, "", headers, options)
  end

  @doc """
  Same as `request/5`, but returns `HTTPoison.Response` or raises an error.
  """
  @spec request!(atom, String.t, body, headers, Keyword.t) :: HTTPoison.Response.t
  def request!(method, url, body \\ "", headers \\ [], options \\ []) do
    case request(method, url, body, headers, options) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

end
