defmodule ImsReport.MixProject do
  use Mix.Project

  def project do
    [
      app: :ims_report,
      version: "0.1.0",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :mongodb_ecto, :task_bunny],
      mod: {ImsReport.Application, []}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 2.1.6", override: true},
      {:mongodb_ecto, "~> 0.2.1"},
      {:task_bunny, "~> 0.3.4"},
      {:mock, "~> 0.3.0", only: :test},
      {:csv, "~> 2.4"}
    ]
  end
end
