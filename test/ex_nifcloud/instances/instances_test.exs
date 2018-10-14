defmodule ExNifcloud.Computing.Test do
  use ExUnit.Case, async: true

  doctest ExNifcloud.Computing

  alias ExNifcloud.Computing.Instances
  alias Test.ExNifclod.Computing.Helper

  # --------------- #
  # Instances Tests #
  # --------------- #

  test "describe_instances no options" do
    expected = Helper.build_query(:describe_instances, %{})
    assert expected == Instances.describe_instances()
  end

  test "describe_instances with instance Ids" do
    expected =
      Helper.build_query(
        :describe_instances,
        %{
          "InstanceId.1": "hogehoge",
          "InstanceId.2": "fugafuga"
        }
      )

    assert expected == Instances.describe_instances(instance_ids: ["hogehoge", "fugafuga"])
  end
end
