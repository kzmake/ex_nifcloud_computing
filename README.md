ExNifcloud.Computing
================

Description
-----------

[ExNifcloud](https://github.com/kzmake/ex_nifcloud) で使用する Operations を作成するための Computing 系サービスのモジュールです。

Getting Started
------------

追加したいプロジェクトの　`mix.exs` に 

- `:ex_nifcloud`
- `:ex_nifcloud_computing`

のパッケージを追加し、 `mix deps.get` で依存パッケージをインストールします。

```elixir
def deps do
  [
    {:ex_nifcloud, git: "https://github.com/kzmake/ex_nifcloud.git", branch: "master"},
    {:ex_nifcloud_computing, git: "https://github.com/kzmake/ex_nifcloud_computing.git", branch: "master"},
  ]
end
```

`ExNifcloud.Computing.{リソース名}.{API名}` で生成したオペレーションを `ExNifcloud.request` へパイプさせることで Computing APIs をリクエストします。

```sh
mix run -e 'ExNifcloud.Computing.Instances.describe_instances |> ExNifcloud.request |> IO.inspect'
```

Install
-------

まだ Hex にあげてない。 github から引っ張ってきて。

```elixir
def deps do
  [
    {:ex_nifcloud, git: "https://github.com/kzmake/ex_nifcloud.git", branch: "master"},
    {:ex_nifcloud_computing, git: "https://github.com/kzmake/ex_nifcloud_computing.git", branch: "master"},
  ]
end
```

Preparation
-----------

Nifcloud APIs を利用方法は [ExNifcloud](https://github.com/kzmake/ex_nifcloud) を参照してください。

Usage
-----

下記のパッケージインストール済みのプロジェクトにて `iex -S mix` などで実施できます。

- `:ex_nifcloud`
- `:ex_nifcloud_computing`

`ExNifcloud.Computing.{リソース名}.{API名}` でリクエストしたいクエリを作成し、 `|>` で `ExNifcloud.request` へ渡すことでリクエストします。

```elixir
iex> ExNifcloud.Computing.Instances.describe_instances |> ExNifcloud.request
{:ok,
  %{
    body: "...",
    headers: [...],
    status_code: 200
  }
}
```

Requirements
------------

このプロジェクトを実行するには以下が必要です:

* [elixir](https://elixir-lang.org) 1.6.+

Contributing
------------

PR歓迎してます


Support and Migration
---------------------

特に無し

License
-------

- [MIT License](http://petitviolet.mit-license.org/)
