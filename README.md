# YelpEx

An Elixir client for the Yelp Fusion API (aka *Yelp's API v3*).

See the Yelp API docs [here](https://www.yelp.com/developers/documentation/v3/).

See the [Hex documentation](https://hex.pm/packages/yelp_ex) for more information.


## Installation

Add `:yelp_ex` to your `mix.exs` file as a dependency and to your `extra_applications` list:

```elixir
def application do
  [extra_applications: [:logger, :yelp_ex]]
end

defp deps do
  [{:yelp_ex, "~> 0.1.1"}]
end
```

Then, run: `mix do deps.get, compile`


## Yelp Setup

In order to use `YelpEx`, you need to create an application on [Yelp's developer website](https://www.yelp.com/developers/v3/manage_app). After you do this, you will get an "App ID" and an "App Secret".

Yelp uses `OAuth2.0` to authenticate using the *client credentials* grant type.

Before starting your application, you will need to save your Yelp API credentials as **environment variables**...

Place a file called `.env` in your project root with the following:

```bash
export CLIENT_ID="<YOUR_YELP_APP_ID>"
export CLIENT_SECRET="<YOUR_YELP_APP_SECRET>"
```

Execute the file from the command line:

```bash
$ source .env
```

_**When you start your application, an authenticated, supervised `YelpEx.Client` will also be started.**_

```bash
$ iex -S mix
```


## Usage
_Click endpoint links to see all valid parameters that can be passed in `options`._

#### [/businesses/search](https://www.yelp.com/developers/documentation/v3/business_search) Endpoint

```elixir
iex> options = [params: [sort_by: "distance", longitude: -75.145101, latitude: 39.54364]]
[params: [sort_by: "distance", longitude: -75.145101, latitude: 39.54364]]

iex> YelpEx.Client.search(options)
{:ok, {<RESPONSE>}}

iex> YelpEx.Client.search!(options)
{<RESPONSE>}
```
