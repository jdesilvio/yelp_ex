defmodule YelpEx.Mixfile do
  use Mix.Project

  @version "0.2.0"

  def project do
    [app: :yelp_ex,
     name: "YelpEx",
     version: @version,
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package(),
     description: description(),
     docs: docs()]
  end

  def application do
    [applications: [:logger, :oauth2, :httpoison],
    mod: {YelpEx, []}]
  end

  defp deps do
    [{:oauth2, "~> 0.8 or ~> 0.9"},
     {:poison, "~> 3.0 or ~> 3.1 or ~> 4.0"},
     {:httpoison, "~> 0.10.0 or ~> 0.13 or ~> 1.2"},
     {:ex_doc, "~> 0.14", only: :dev}]
  end

  defp description do
    "An Elixir client for the Yelp Fusion API (Yelp API v3)"
  end

  defp docs do
    [extras: ["README.md"],
     main: "readme",
     source_ref: "v#{@version}",
     source_url: "https://github.com/jdesilvio/yelp_ex"]
  end

  defp package do
    [files: ["lib", "mix.exs", "README.md", "LICENSE"],
     maintainers: ["John DeSilvio"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/jdesilvio/yelp_ex"}]
  end
end
