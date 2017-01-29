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
    GenServer.start_link(__MODULE__, nil, options)
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

  def get_call(pid, url, headers \\ [], options \\ []) do
    GenServer.call(pid, {:get, url, "", headers, options})
  end

  ## Server callbacks

  def init(nil) do
    case API.get_token do
      {:ok, client} -> {:ok, client}
      {:error, error} -> {:stop, error.reason}
    end
  end

  def handle_call({method, url, body, headers, options}, _from, client) do
    auth = [auth: "#{client.token.token_type} #{client.token.access_token}"]
    headers = headers ++ auth
    case API.request(method, url, body, headers, options) do
      {:ok, %HTTPoison.Response{body: body}} -> {:reply, {:ok, body}, client}
      {:ok, response} -> {:reply, {:ok, response}, client}
      {:error, error} -> {:reply, {:error, error}, client}
    end
  end

  @doc """
  Generates a *singleton* Twitter client.
  """
  defmacro __using__(_) do
    quote do
      @doc false
      def start_link(options \\ []) do
        YelpElixir.Client.Base.start_link(options ++ [name: __MODULE__])
      end

      defp get(url, headers \\ [], options \\ []) do
        YelpElixir.Client.Base.get_call(__MODULE__, url, headers, options)
      end

      #defp get!(url, headers \\ [], options \\ []) do
        #  YelpElixir.Client.Base.get_call!(__MODULE__, url, headers, options)
        #end
    end
  end

end
