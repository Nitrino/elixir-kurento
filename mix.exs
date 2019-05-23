defmodule KurentoClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :kurento_client,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description(),
      name: "Kurento Client",
      source_url: "https://github.com/Nitrino/kurento_client",
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE*"],
      maintainers: ["Petr Stepchenko"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/Nitrino/kurento_client"}
    ]
  end

  defp description do
    """
    Kurento Media Server Client for Elixir programming language
    """
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
