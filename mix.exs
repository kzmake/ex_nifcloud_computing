defmodule ExNifcloud.Computing.MixProject do
  use Mix.Project

  @version "0.0.1"
  @service "computing"
  @url "https://github.com/kzmake/ex_nifcloud_#{@service}"
  @name __MODULE__
        |> Module.split()
        |> Enum.take(2)
        |> Enum.join(".")

  def project do
    [
      app: :ex_nifcloud_computing,
      version: @version,
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: @name,
      package: package(),
      docs: [
        main: @name,
        source_ref: "v#{@version}",
        source_url: @url
      ]
    ]
  end

  defp package do
    [
      description: "#{@name} service package",
      files: ["lib", "config", "mix.exs", "README*"],
      maintainers: ["kzmake"],
      licenses: ["MIT"],
      links: %{
        github: @url
      }
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      switch_ex_nifcloud(),
      {:mix_test_watch, "~> 0.8", only: :dev, runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:earmark, ">= 0.0.0", only: :dev},
      {:hackney, ">= 0.0.0", only: [:dev, :test]}
    ]
  end

  defp switch_ex_nifcloud do
    case String.upcase(System.get_env("EX_NIFCLOUD")) do
      "LOCAL" -> {:ex_nifcloud, path: "../ex_nifcloud"}
      _ -> {:ex_nifcloud, "~> 0.0.1"}
    end
  end
end
