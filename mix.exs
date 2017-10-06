defmodule Attest.Mixfile do
  use Mix.Project

  def project do
    [
      app: :attest,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
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
      {:phoenix, "~> 1.3", optional: true},
      {:phoenix_ecto, "~> 3.2", optional: true},
      {:comeonin, "~> 4.0"},
      {:bcrypt_elixir, "~> 1.0"},
    ]
  end
end
