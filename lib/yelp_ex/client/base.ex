defmodule YelpEx.Client.Base do
  @moduledoc """
  Client implementation module.

  The components in this module can be
  used to build a custom Yelp API client.

  ## Example:

  ```
  defmodule YelpEx.SuperAwesomeClient do

    use YelpEx.Client.Base

    @spec search(Keyword.t) :: {:ok, %{}} | {:error, HTTPoison.Error.t}
    def search(options) do
      get("businesses/search", [], options)
    end

    @spec search!(Keyword.t) :: %{}
    def search!(options) do
      get!("businesses/search", [], options)
    end

  end
  ```

  """

  alias YelpEx.API

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
  @spec get(pid, String.t, API.headers, Keyword.t) :: {:ok,  HTTPoison.Response.t} | {:error, HTTPoison.Error.t}
  def get(pid, endpoint, headers, options \\ []) do
    GenServer.call(pid, {:get, endpoint, "", headers, options})
  end

  @doc """
  Same as `get/4` but raises `HTTPoison.Error` if an error occurs.
  """
  @spec get!(pid, String.t, API.headers, Keyword.t) :: HTTPoison.Response.t
  def get!(pid, endpoint, headers, options \\ []) do
    case get(pid, endpoint, headers, options) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end


  ## Server callbacks

  def init(nil) do
    case System.get_env("YELP_API_KEY") do
      nil -> {:stop, "YELP_API_KEY environment variable must be set"}
      api_key -> {:ok, api_key}
    end
  end

  def handle_call({method, endpoint, body, headers, options}, _from, api_key) do
    auth = ["Authorization": "Bearer #{api_key}"]
    headers = headers ++ auth

    case API.request(method, endpoint, body, headers, options) do
      {:ok, %HTTPoison.Response{body: body}} -> {:reply, {:ok, body}, api_key}
      {:ok, response} -> {:reply, {:ok, response}, api_key}
      {:error, error} -> {:reply, {:error, error}, api_key}
    end
  end

  @doc """
  Generates a *singleton* Yelp client.
  """
  defmacro __using__(_) do
    quote do
      @doc false
      def start_link(options \\ []) do
        YelpEx.Client.Base.start_link(options ++ [name: __MODULE__])
      end

      defp get(endpoint, headers \\ [], options \\ []) do
        YelpEx.Client.Base.get(__MODULE__, endpoint, headers, options)
      end

      defp get!(endpoint, headers \\ [], options \\ []) do
        YelpEx.Client.Base.get!(__MODULE__, endpoint, headers, options)
      end
    end
  end

end
