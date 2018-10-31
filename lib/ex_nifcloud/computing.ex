defmodule ExNifcloud.Computing do
  @moduledoc """
  Computing(Nifcloud) のオペレーション群
  """
  alias ExNifcloud.Computing.Utils

  @type network_interface_spec :: [
          network_interface_id: binary,
          private_ip_address: binary
        ]

  @type license_spec :: [
          license_name: binary,
          license_num: binary
        ]

  @type filter_spec :: [
          name: binary,
          values: [binary, ...]
        ]

  # ---------- #
  # Operations #
  # ---------- #

  @doc """
  インスタンスの情報を取得するための Operation を生成します(インスタンス名を指定して特定のインスタンス情報を取得することも可能)

  ## API Doc:

    - https://cloud.nifty.com/api/rest/DescribeInstances.htm

  ## Examples:

      iex> ExNifcloud.Computing.describe_instances
      %ExNifcloud.Operation.Query{
        action: :describe_instances,
        params: %{},
        parser: &ExNifcloud.Utils.identity/2,
        path: "/api/",
        service: :computing
      }
  """
  @type describe_instances_opts :: [
          instance_ids: [binary, ...]
        ]
  @spec describe_instances() :: ExNifcloud.Operation.Query.t()
  @spec describe_instances(opts :: describe_instances_opts) :: ExNifcloud.Operation.Query.t()
  def describe_instances(opts \\ []) do
    opts
    |> Utils.build_operation(:describe_instances)
  end

  @doc """
  インスタンスを生成するための Operation を生成します

  ## API Doc:

    - https://cloud.nifty.com/api/rest/RunInstances.htm

  ## Examples:

      iex> ExNifcloud.Computing.run_instances("89", key_name: "key_name", security_groups: "security_group_name")
      %ExNifcloud.Operation.Query{
        action: :run_instances,
        params: %{
          ImageId: "89",
          KeyName: "key_name",
          SecurityGroup: "security_group_name"
        },
        parser: &ExNifcloud.Utils.identity/2,
        path: "/api/",
        service: :computing
      }
  """
  @type run_instances_opts :: [
          key_name: binary,
          security_groups: [binary, ...],
          user_data: binary,
          user_data_encoding: binary,
          instance_type: binary,
          availability_zone: binary,
          disable_api_termination: binary,
          accounting_type: binary,
          instance_id: binary,
          admin: binary,
          password: binary,
          ip_type: binary,
          public_ip: binary,
          agreement: binary,
          description: binary,
          network_interfaces: [network_interface_spec, ...],
          licenses: [license_spec, ...]
        ]
  @spec run_instances(image_id :: binary) :: ExNifcloud.Operation.Query.t()
  @spec run_instances(image_id :: binary, opts :: run_instances_opts) ::
          ExNifcloud.Operation.Query.t()
  def run_instances(image_id, opts \\ []) do
    [
      {:image_id, image_id}
      | opts
    ]
    |> Utils.build_operation(:run_instances)
  end

  @doc """
  インスタンスを停止するための Operation を生成します

  ## API Doc:

    - https://cloud.nifty.com/api/rest/StopInstances.htm

  ## Examples:

      iex> ExNifcloud.Computing.stop_instances(["instance_name_1", "instance_name_2"], force: "true")
      %ExNifcloud.Operation.Query{
        action: :stop_instances,
        params: %{
          "InstanceId.1": "instance_name_1",
          "InstanceId.2": "instance_name_2",
          Force: "true"
        },
        parser: &ExNifcloud.Utils.identity/2,
        path: "/api/",
        service: :computing
      }
  """
  @type stop_instances_opts :: [
          force: binary
        ]
  @spec stop_instances(instance_ids :: [binary, ...]) :: ExNifcloud.Operation.Query.t()
  @spec stop_instances(instance_ids :: [binary, ...], opts :: stop_instances_opts) ::
          ExNifcloud.Operation.Query.t()
  def stop_instances(instance_ids, opts \\ []) do
    [{:instance_ids, instance_ids} | opts]
    |> Utils.build_operation(:stop_instances)
  end

  @doc """
  インスタンスを削除するための Operation を生成します

  ## API Doc:

    - https://cloud.nifty.com/api/rest/TerminateInstances.htm

  ## Examples:

      iex> ExNifcloud.Computing.terminate_instances(["instance_name_1", "instance_name_2"])
      %ExNifcloud.Operation.Query{
        action: :terminate_instances,
        params: %{
          "InstanceId.1": "instance_name_1",
          "InstanceId.2": "instance_name_2"
        },
        parser: &ExNifcloud.Utils.identity/2,
        path: "/api/",
        service: :computing
      }
  """
  @spec terminate_instances(instance_ids :: [binary, ...]) :: ExNifcloud.Operation.Query.t()

  def terminate_instances(instance_ids) do
    [{:instance_ids, instance_ids}]
    |> Utils.build_operation(:terminate_instances)
  end

  @doc """
  インスタンスの詳細情報を取得するための Operation を生成します

  ## API Doc:

    - https://cloud.nifty.com/api/rest/DescribeInstanceAttribute.htm

  ## Examples:

      iex> ExNifcloud.Computing.describe_instance_attribute("instance_name", attribute: "instanceType")
      %ExNifcloud.Operation.Query{
        action: :describe_instance_attribute,
        params: %{
          InstanceId: "instance_name",
          Attribute: "instanceType"
        },
        parser: &ExNifcloud.Utils.identity/2,
        path: "/api/",
        service: :computing
      }
  """
  @type describe_instance_attribute_opts :: [
          attribute: binary
        ]
  @spec describe_instance_attribute(instance_id :: binary) :: ExNifcloud.Operation.Query.t()
  @spec describe_instance_attribute(
          instance_id :: binary,
          opts :: describe_instance_attribute_opts
        ) :: ExNifcloud.Operation.Query.t()
  def describe_instance_attribute(instance_id, opts \\ []) do
    [{:instance_id, instance_id} | opts]
    |> Utils.build_operation(:describe_instance_attribute)
  end

  @doc """
  インスタンスの情報を更新するための Operation を生成します

  ## API Doc:

    - https://cloud.nifty.com/api/rest/ModifyInstanceAttribute.htm

  ## Examples:

      iex> ExNifcloud.Computing.modify_instance_attribute("instance_name", "instanceType", "small")
      %ExNifcloud.Operation.Query{
        action: :modify_instance_attribute,
        params: %{
          InstanceId: "instance_name",
          Attribute: "instanceType",
          Value: "small"
        },
        parser: &ExNifcloud.Utils.identity/2,
        path: "/api/",
        service: :computing
      }
  """
  @type modify_instance_attribute_opts :: [
          nifty_reboot: binary,
          force: binary,
          tenancy: binary
        ]
  @spec modify_instance_attribute(instance_id :: binary, attribute :: binary, value :: binary) ::
          ExNifcloud.Operation.Query.t()
  @spec modify_instance_attribute(
          instance_id :: binary,
          attribute :: binary,
          value :: binary,
          opts :: modify_instance_attribute_opts
        ) :: ExNifcloud.Operation.Query.t()
  def modify_instance_attribute(instance_id, attribute, value, opts \\ []) do
    [{:instance_id, instance_id}, {:attribute, attribute}, {:value, value} | opts]
    |> Utils.build_operation(:modify_instance_attribute)
  end

  @doc """
  インスタンスを Reboot するための Operation を生成します

  ## API Doc:

    - https://cloud.nifty.com/api/rest/RebootInstances.htm

  ## Examples:

      iex> ExNifcloud.Computing.reboot_instances(["instance_name_1", "instance_name_2"])
      %ExNifcloud.Operation.Query{
        action: :reboot_instances,
        params: %{
          "InstanceId.1": "instance_name_1",
          "InstanceId.2": "instance_name_2"
        },
        parser: &ExNifcloud.Utils.identity/2,
        path: "/api/",
        service: :computing
      }
  """
  @type reboot_instances_opts :: [
          user_data: binary,
          user_data_encoding: binary,
          force: binary,
          nifty_is_bios: binary,
          tenancys: [binary, ...]
        ]
  @spec reboot_instances(instance_ids :: [binary, ...]) :: ExNifcloud.Operation.Query.t()
  @spec reboot_instances(
          instance_ids :: [binary, ...],
          opts :: reboot_instances_opts
        ) :: ExNifcloud.Operation.Query.t()
  def reboot_instances(instance_ids, opts \\ []) do
    [{:instance_ids, instance_ids} | opts]
    |> Utils.build_operation(:reboot_instances)
  end

  @doc """
  インスタンスを起動するための Operation を生成します

  ## API Doc:

    - https://cloud.nifty.com/api/rest/StartInstances.htm

  ## Examples:

      iex> ExNifcloud.Computing.start_instances(["instance_name_1", "instance_name_2"])
      %ExNifcloud.Operation.Query{
        action: :start_instances,
        params: %{
          "InstanceId.1": "instance_name_1",
          "InstanceId.2": "instance_name_2"
        },
        parser: &ExNifcloud.Utils.identity/2,
        path: "/api/",
        service: :computing
      }
  """
  @type start_instances_opts :: [
          user_data: binary,
          user_data_encoding: binary,
          accountung_types: [binary, ...],
          instance_types: [binary, ...],
          nifty_is_bios: binary,
          tenancys: [binary, ...]
        ]
  @spec start_instances(instance_ids :: [binary, ...]) :: ExNifcloud.Operation.Query.t()
  @spec start_instances(
          instance_ids :: [binary, ...],
          opts :: start_instances_opts
        ) :: ExNifcloud.Operation.Query.t()
  def start_instances(instance_ids, opts \\ []) do
    [{:instance_ids, instance_ids} | opts]
    |> Utils.build_operation(:start_instances)
  end

  @doc """
  ネットワークインターフェースの情報を取得するための Operation を生成します(ネットワークインターフェースの UniqueId を指定して特定の情報を取得することも可能)

  ## API Doc:

    - https://cloud.nifty.com/api/rest/DescribeNetworkInterfaces.htm

  ## Examples:

      iex> ExNifcloud.Computing.describe_network_interfaces(network_interface_ids: ["ni-xxxxxxxx", "ni-yyyyyyyy"])
      %ExNifcloud.Operation.Query{
        action: :describe_network_interfaces,
        params: %{
          "NetworkInterfaceId.1": "ni-xxxxxxxx",
          "NetworkInterfaceId.2": "ni-yyyyyyyy"
        },
        parser: &ExNifcloud.Utils.identity/2,
        path: "/api/",
        service: :computing
      }
  """
  @type describe_network_interfaces_opts :: [
          network_interface_ids: [binary, ...],
          filters: [filter_spec, ...]
        ]
  @spec describe_network_interfaces() :: ExNifcloud.Operation.Query.t()
  @spec describe_network_interfaces(opts :: describe_network_interfaces_opts) ::
          ExNifcloud.Operation.Query.t()
  def describe_network_interfaces(opts \\ []) do
    opts
    |> Utils.build_operation(:describe_network_interfaces)
  end

  @doc """
  ネットワークインターフェースを生成するための Operation を生成します

  ## API Doc:

    - https://cloud.nifty.com/api/rest/CreateNetworkInterface.htm

  ## Examples:

      iex> ExNifcloud.Computing.create_network_interface("net-xxxxxxxx")
      %ExNifcloud.Operation.Query{
        action: :create_network_interface,
        params: %{
          NiftyNetworkId: "net-xxxxxxxx",
        },
        parser: &ExNifcloud.Utils.identity/2,
        path: "/api/",
        service: :computing
      }
  """
  @type create_network_interface_opts :: [
          ip_address: binary,
          placement_availability_zone: binary,
          description: binary
        ]
  @spec create_network_interface(network_id :: binary) :: ExNifcloud.Operation.Query.t()
  @spec create_network_interface(network_id :: binary, opts :: create_network_interface_opts) ::
          ExNifcloud.Operation.Query.t()
  def create_network_interface(network_id, opts \\ []) do
    [{:nifty_network_id, network_id} | opts]
    |> Utils.build_operation(:create_network_interface)
  end

  @doc """
  ネットワークインターフェースを削除するための Operation を生成します

  ## API Doc:

    - https://cloud.nifty.com/api/rest/DeleteNetworkInterface.htm

  ## Examples:

      iex> ExNifcloud.Computing.delete_network_interface("ni-xxxxxxxx")
      %ExNifcloud.Operation.Query{
        action: :delete_network_interface,
        params: %{
          NetworkInterfaceId: "ni-xxxxxxxx",
        },
        parser: &ExNifcloud.Utils.identity/2,
        path: "/api/",
        service: :computing
      }
  """
  @spec delete_network_interface(network_interface_id :: binary) :: ExNifcloud.Operation.Query.t()
  def delete_network_interface(network_interface_id) do
    [{:network_interface_id, network_interface_id}]
    |> Utils.build_operation(:delete_network_interface)
  end
end
