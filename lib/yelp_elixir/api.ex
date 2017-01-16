defmodule YelpElixir.API do
  @moduledoc """
  Provides functionality to interact with the Yelp API.

  https://api.yelp.com

  ### Examples

  ```
  # Using envrironment variables
  client = YelpElixir.API.get_token!

  # Creating your own client
  client = YelpElixir.API.create_client(client_id="abc", client_secret="z123")
  client = YelpElixir.API.get_token!(client)
  ```
  """

  alias OAuth2

  @client OAuth2.Client.new([
      strategy: OAuth2.Strategy.ClientCredentials,
      client_id: System.get_env("CLIENT_ID"),
      client_secret: System.get_env("CLIENT_SECRET"),
      site: "https://api.yelp.com",
      token_url: "/oauth2/token"
  ])

  @doc """
  Create a client with credentials to
  interact with the Yelp API server.
  """
  def create_client(client_id, client_secret) do
    client = OAuth2.Client.new([
      strategy: OAuth2.Strategy.ClientCredentials,
      client_id: client_id,
      client_secret: client_secret,
      site: "https://api.yelp.com",
      token_url: "/oauth2/token"
    ])
  end

  def get_token do
    :not_implemented
  end

  @doc """
  Gets the Yelp API access token.

  `get_token!/0` uses the default @client
  that was created using environment variables.

  `get_token!/1` takes any %OAuth2.Client{}
  struct as an input. This should be created
  by using `create_client/2`.

  Returns original %OAuth2.Client{} with the
  `AccessToken` key added.
  """
  def get_token!(client \\ @client)
  def get_token!(client) do
    OAuth2.Client.get_token!(
      client,
      params = [
        grant_type: "client_credentials",
        client_id: client.client_id,
        client_secret: client.client_secret
      ]
    )
  end

  @doc """
  Refreshes the Yelp API access token.
  """
  def refresh_token do
    :not_implemented
  end

  def request do
    :not_implemented
  end

end
