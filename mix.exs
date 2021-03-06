defmodule Kurento.MixProject do
  use Mix.Project

  def project do
    [
      app: :kurento,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description(),
      name: "Kurento Client",
      source_url: "https://github.com/Nitrino/elixir-kurento",
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE*"],
      maintainers: ["Petr Stepchenko"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/Nitrino/elixir-kurento"}
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
      {:websockex, "~> 0.4.2"},
      {:jason, "~> 1.1"}
    ]
  end
end
