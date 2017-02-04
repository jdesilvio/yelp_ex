defmodule YelpEx do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(YelpEx.Client, [])
    ]

    opts = [strategy: :one_for_one, name: YelpEx.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
