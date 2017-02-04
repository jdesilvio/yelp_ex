# YelpElixir

An Elixir wrapper for the Yelp API v3.

See the Yelp API [docs](https://www.yelp.com/developers/documentation/v3/).

## Yelp Setup

First, you need to create an app on [Yelp's developer website](https://www.yelp.com/developers/v3/manage_app). After you do this you will get an "App ID" and an "App Secret".

Yelp uses OAuth2.0 to authenticate using the *client credentials* grant type. Going forward, we will use any variation of:

* `Client ID` to mean `App ID`
* `Client Secret` to mean `App Secret`

## Authentication

### There are currently 2 ways to authenticate:

**Use environment variables:**

Place a file `.env` in your project root with the following:

    export CLIENT_ID="<YOUR_CLIENT_ID>"
    export CLIENT_SECRET="<YOUR_CLIENT_SECRET>"

Execute the file from the command line:

```bash
$ source .env
```

Get your access token in `IEx`:

```bash
$ iex -S mix
```
```elixir
iex> token = YelpElixir.API.get_token!
%OAuth2.AccessToken{}
```

**Supply your credentials in `IEx`:**

```bash
$ iex -S mix
```
```elixir
iex> client = YelpElixir.API.create_client(client_id="<YOUR_CLIENT_ID>", client_secret="<YOUR_CLIENT_SECRET>")
%OAuth2.Client{}

iex> token = YelpElixir.API.get_token!(client)
%OAuth2.AccessToken{}
```

## Usage

### [/businesses/search](https://www.yelp.com/developers/documentation/v3/business_search) Endpoint

```elixir
iex> options = [params: [sort_by: "distance", longitude: -75.145101, latitude: 39.54364]]
[params: [sort_by: "distance", longitude: -75.145101, latitude: 39.54364]]

iex> YelpElixir.Client.search(client, options)
{:ok, {...your results...}}
```
