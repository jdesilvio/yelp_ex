# YelpElixir

An Elixir wrapper for the Yelp API v3.

See the Yelp API [docs](https://www.yelp.com/developers/documentation/v3/).


## Yelp Setup

First, you need to create an app on [Yelp's developer website](https://www.yelp.com/developers/v3/manage_app). After you do this you will get an "App ID" and an "App Secret".

Yelp uses OAuth2.0 to authenticate using the *client credentials* grant type.


## Installation

Add `YelpElixir` to your `mix.exs` file as a dependency:

```elixir
defp deps do
  [{:yelp_elixir, github: "jdesilvio/yelp-elixir"}]
end
```

Now, run: `mix do deps.get, compile`

Then, add `:yelp_elixir` to your `extra_applications` list in `mix.exs`:

```elixir
def application do
  [extra_applications: [:logger, :yelp_elixir]]
end
```

Finally, you will need to give your application access to your Yelp API credentials via **environment variables**...

Place a file called `.env` in your project root with the following:

```bash
export CLIENT_ID="<YOUR_YELP_APP_ID>"
export CLIENT_SECRET="<YOUR_YELP_APP_SECRET>"
```

Execute the file from the command line:

```bash
$ source .env
```

_**When you start your app, an authenticated, supervised `YelpElixir.Client` will also be started.**_


## Usage
_Click endpoint links to see all valid parameters that can be passed in `options`._

#### [/businesses/search](https://www.yelp.com/developers/documentation/v3/business_search) Endpoint

```elixir
iex> options = [params: [sort_by: "distance", longitude: -75.145101, latitude: 39.54364]]
[params: [sort_by: "distance", longitude: -75.145101, latitude: 39.54364]]

iex> YelpElixir.Client.search(options)
{:ok, %{...your results...}}

iex> YelpElixir.Client.search!(options)
%{...your results...}
```
