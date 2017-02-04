defmodule YelpEx do
  @moduledoc """
  An Elixir client for the Yelp Fusion API.
  """

  use Application

  @doc false
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(YelpEx.Client, [])
    ]

    opts = [strategy: :one_for_one, name: YelpEx.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
