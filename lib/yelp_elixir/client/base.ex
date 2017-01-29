defmodule YelpElixir.Client.Base do
  @moduledoc """
  Client implementation module.

  ## Example:

      client = YelpElixir.API.get_token!
      options = [params: [sort_by: "distance", longitude: -75.145101, latitude: 39.54364]]
      YelpElixir.Client.Base.get(client, "businesses/search", options)
  """

  alias YelpElixir.API

  use GenServer

  @doc """
  Starts a supervised GenServer.

  Further options are passed to `GenServer.start_link/1`.
  """
  @spec start_link(Keyword.t) :: GenServer.on_start
  def start_link(options \\ []) do
    GenServer.start_link(__MODULE__, nil, [name: __MODULE__])
  end

  @doc """
  Issues a GET request.
  """
  @spec get(%OAuth2.Client{}, String.t, Keyword.t) :: {:ok,  OAuth2.Response.t} | {:error, HTTPoison.Error.t}
  def get(client, endpoint, options) do
    headers = [auth: "#{client.token.token_type} #{client.token.access_token}"]

    API.request(:get, headers, endpoint, options)
  end

  @doc """
  Same as `get/3` but raises `HTTPoison.error` if an error occurs.
  """
  @spec get!(%OAuth2.Client{}, String.t, Keyword.t) ::  OAuth2.Response.t
  def get!(client, endpoint, options) do
    case get(client, endpoint, options) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end


  ## Server callbacks

  def init(nil) do
    case API.get_token do
      {:ok, token} -> {:ok, token}
      {:error, error} -> {:stop, error.reason}
    end
  end

  #  def handle_call({method, url, body, headers, options}, _from, token) do
  #    case API.request(method, url, body, headers, [{:auth, token} | options]) do
  #      {:ok, %HTTPoison.Response{body: body}} -> {:reply, {:ok, body}, token}
  #      {:ok, response} -> {:reply, {:ok, response}, token}
  #      {:error, error} -> {:reply, {:error, error}, token}
  #    end
  #  end

end
