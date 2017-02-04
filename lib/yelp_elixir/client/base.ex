defmodule YelpElixir.Client.Base do
  @moduledoc """
  Client implementation module.

  The components in this module can be
  used to build a custom Yelp API client.

  ## Example:

      ```
      defmodule YelpElixir.SuperAwesomeClient do

        use YelpElixir.Client.Base

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
  @spec get(pid, String.t, API.headers, Keyword.t) :: {:ok,  OAuth2.Response.t} | {:error, HTTPoison.Error.t}
  def get(pid, endpoint, headers, options \\ []) do
    GenServer.call(pid, {:get, endpoint, "", headers, options})
  end

  @doc """
  Same as `get` but raises `HTTPoison.error` if an error occurs.
  """
  @spec get(pid, String.t, API.headers, Keyword.t) :: OAuth2.Response.t
  def get!(pid, endpoint, headers, options \\ []) do
    case get(pid, endpoint, headers, options) do
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

  def handle_call({method, endpoint, body, headers, options}, _from, token) do
    auth = ["Authorization": "#{token.token_type} #{token.access_token}"]
    headers = headers ++ auth

    case API.request(method, endpoint, body, headers, options) do
      {:ok, %HTTPoison.Response{body: body}} -> {:reply, {:ok, body}, token}
      {:ok, response} -> {:reply, {:ok, response}, token}
      {:error, error} -> {:reply, {:error, error}, token}
    end
  end

  @doc """
  Generates a *singleton* Yelp client.
  """
  defmacro __using__(_) do
    quote do
      @doc false
      def start_link(options \\ []) do
        YelpElixir.Client.Base.start_link(options ++ [name: __MODULE__])
      end

      defp get(endpoint, headers \\ [], options \\ []) do
        YelpElixir.Client.Base.get(__MODULE__, endpoint, headers, options)
      end

      defp get!(endpoint, headers \\ [], options \\ []) do
        YelpElixir.Client.Base.get!(__MODULE__, endpoint, headers, options)
      end
    end
  end

end
