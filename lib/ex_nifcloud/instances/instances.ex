defmodule ExNifcloud.Computing.Instances do
  @moduledoc """
  Computing(Nifcloud) の Instance リソースに関連するオペレーション群
  """

  alias ExNifcloud.Computing

  @type filter :: {name :: binary | atom, value :: [binary, ...]}

  # ---------- #
  # Operations #
  # ---------- #

  @doc """
  インスタンスの情報を取得します(インスタンス名を指定して特定のインスタンス情報を取得することも可能)

  ## API Doc:

    - [https://cloud.nifty.com/api/rest/DescribeInstances.htm](https://cloud.nifty.com/api/rest/DescribeInstances.htm)

  ## Examples:

      iex> ExNifcloud.Computing.Instance.describe_instances
      %ExNifcloud.Operation.Query{
        action: :describe_instances,
        params: %{Action: "DescribeInstances"},
        parser: &ExNifcloud.Utils.identity/2,
        path: "/api/",
        service: :computing
      }

      iex> ExNifcloud.Computing.Instance.describe_instances(instance_ids: ["hoge", "fuga"])
      %ExNifcloud.Operation.Query{
        action: :describe_instances,
        params: %{
          Action: "DescribeInstances",
          "InstanceId.1": "hoge",
          "InstanceId.2": "fuga"
        },
        parser: &ExNifcloud.Utils.identity/2,
        path: "/api/",
        service: :computing
      }
  """
  @type describe_instances_opts :: [
          instance_ids: [binary, ...],
          filters: [filter, ...]
        ]
  @spec describe_instances() :: ExNifcloud.Operation.Query.t()
  @spec describe_instances(opts :: describe_instances_opts) :: ExNifcloud.Operation.Query.t()
  def describe_instances(opts \\ []) do
    opts
    |> Computing.build_request(:describe_instances)
  end
end
