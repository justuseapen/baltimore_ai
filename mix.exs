defmodule BaltimoreAi.MixProject do
  use Mix.Project

  def project do
    [
      app: :baltimore_ai,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {BaltimoreAi.Application, []},
      extra_applications: [:logger, :runtime_tools, :scrivener_ecto, :ueberauth_google, :httpotion, :timex]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # Phoenix
      {:phoenix, "~> 1.4.0"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_html_sanitizer, "~> 1.0.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:httpotion, "~> 3.1.0"},

      # Authentication
      {:ueberauth, "~> 0.5.0"},
      {:ueberauth_google, "~> 0.8"},
      {:ja_serializer, "~> 0.11.2"},
      {:guardian, "~> 1.0"},
      {:comeonin, "~> 4.1"},
      {:bcrypt_elixir, "~> 1.0"},

      # Misc
      {:scrivener_ecto, "~> 2.0"},
      {:slugger, "~> 0.2"},
      {:timex, "~> 3.1"},

      # Tests
      {:mock, "~> 0.3.0", only: :test}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
