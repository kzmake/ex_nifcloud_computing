defmodule ExNifcloud.Computing.Test do
  use ExUnit.Case, async: true

  doctest ExNifcloud.Computing

  alias ExNifcloud.Computing
  alias Test.ExNifclod.Computing.Helper

  # ------------------------ #
  # Network Interfaces Tests #
  # ------------------------ #

  test "describe_network_instances no options" do
    expected = Helper.build_query(:describe_network_interfaces, %{})
    assert expected == Computing.describe_network_interfaces()
  end

  test "describe_network_instances with ops" do
    expected =
      Helper.build_query(
        :describe_network_interfaces,
        %{
          "NetworkInterface.1": "ni-xxxxxxxx",
          "NetworkInterface.2": "ni-yyyyyyyy",
          "Filter.1.Name": "description",
          "Filter.1.Value.1": "aaaa",
          "Filter.1.Value.2": "bbbb"
        }
      )

    assert expected ==
             Computing.describe_network_interfaces(
               network_interfaces: ["ni-xxxxxxxx", "ni-yyyyyyyy"],
               filters: [
                 [
                   name: "description",
                   value: ["aaaa", "bbbb"]
                 ]
               ]
             )
  end

  test "create_network_interface with ops" do
    expected =
      Helper.build_query(
        :create_network_interface,
        %{
          NiftyNetworkId: "net-xxxxxxxx",
          IpAddress: "static",
          "Placement.AvailabilityZone": "east-11",
          Description: "description"
        }
      )

    assert expected ==
             Computing.create_network_interface(
               "net-xxxxxxxx",
               ip_address: "static",
               placement_availability_zone: "east-11",
               description: "description"
             )
  end

  # --------------- #
  # Instances Tests #
  # --------------- #

  test "describe_instances no options" do
    expected = Helper.build_query(:describe_instances, %{})
    assert expected == Computing.describe_instances()
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

    assert expected == Computing.describe_instances(instance_ids: ["hogehoge", "fugafuga"])
  end

  test "run_instances no options" do
    expected = Helper.build_query(:run_instances, %{ImageId: "1"})
    assert expected == Computing.run_instances("1")
  end

  test "run_instances with options" do
    expected =
      Helper.build_query(
        :run_instances,
        %{
          ImageId: "1",
          KeyName: "key_name",
          "SecurityGroup.1": "security_group_name",
          AccountingType: "1",
          Admin: "root",
          Agreement: "true",
          AvailabilityZone: "east-11",
          Description: "description",
          DisableApiTermination: "false",
          InstanceId: "instance_name",
          InstanceType: "large",
          IpType: "elastic",
          Password: "1234",
          PublicIp: "192.0.2.10",
          UserData: "user_data",
          "UserData.Encoding": "",
          "NetworkInterface.1.NetworkId": "net-COMMON_GLOBAL",
          "NetworkInterface.1.IpAddress": "192.0.2.10",
          "NetworkInterface.2.NetworkName": "network_name",
          "NetworkInterface.2.IpAddress": "192.0.2.11",
          "License.1.LicenseName": "Office(Pro Plus)",
          "License.1.LicenseNum": "100",
          "License.2.LicenseName": "Office(Std)",
          "License.2.LicenseNum": "200"
        }
      )

    assert expected ==
             Computing.run_instances(
               "1",
               key_name: "key_name",
               security_groups: ["security_group_name"],
               user_data: "user_data",
               user_data_encoding: "",
               instance_type: "large",
               availability_zone: "east-11",
               disable_api_termination: "false",
               accounting_type: "1",
               instance_id: "instance_name",
               admin: "root",
               password: "1234",
               ip_type: "elastic",
               public_ip: "192.0.2.10",
               agreement: "true",
               description: "description",
               network_interfaces: [
                 [
                   network_id: "net-COMMON_GLOBAL",
                   ip_address: "192.0.2.10"
                 ],
                 [
                   network_name: "network_name",
                   ip_address: "192.0.2.11"
                 ]
               ],
               licenses: [
                 [
                   license_name: "Office(Pro Plus)",
                   license_num: "100"
                 ],
                 [
                   license_name: "Office(Std)",
                   license_num: "200"
                 ]
               ]
             )
  end

  test "stop_instances with options" do
    expected =
      Helper.build_query(
        :stop_instances,
        %{
          Force: "true",
          "InstanceId.1": "instance_name_a",
          "InstanceId.2": "instance_name_b"
        }
      )

    assert expected ==
             Computing.stop_instances(["instance_name_a", "instance_name_b"], force: "true")
  end

  test "terminate_instances no options" do
    expected =
      Helper.build_query(
        :terminate_instances,
        %{
          "InstanceId.1": "instance_name_a",
          "InstanceId.2": "instance_name_b"
        }
      )

    assert expected == Computing.terminate_instances(["instance_name_a", "instance_name_b"])
  end

  test "describe_instance_attribute with options" do
    expected =
      Helper.build_query(
        :describe_instance_attribute,
        %{
          InstanceId: "instance_name",
          Attribute: "disableApiTermination"
        }
      )

    assert expected ==
             Computing.describe_instance_attribute(
               "instance_name",
               attribute: "disableApiTermination"
             )
  end

  test "modify_instance_attribute with options" do
    expected =
      Helper.build_query(
        :modify_instance_attribute,
        %{
          InstanceId: "instance_name",
          Attribute: "disableApiTermination",
          Value: "false",
          Force: "true",
          NiftyReboot: "force",
          Tenancy: "dedicated"
        }
      )

    assert expected ==
             Computing.modify_instance_attribute(
               "instance_name",
               "disableApiTermination",
               "false",
               nifty_reboot: "force",
               force: "true",
               tenancy: "dedicated"
             )
  end

  test "reboot_instances with options" do
    expected =
      Helper.build_query(
        :reboot_instances,
        %{
          "InstanceId.1": "instance_name_1",
          "InstanceId.2": "instance_name_2",
          UserData: "script",
          "UserData.Encoding": "base64",
          Force: "true",
          NiftyIsBios: "false",
          "Tenancy.1": "all"
        }
      )

    assert expected ==
             Computing.reboot_instances(
               ["instance_name_1", "instance_name_2"],
               user_data: "script",
               user_data_encoding: "base64",
               force: "true",
               nifty_is_bios: "false",
               tenancys: ["all"]
             )
  end

  test "start_instances with options" do
    expected =
      Helper.build_query(
        :start_instances,
        %{
          "InstanceId.1": "instance_name_1",
          "InstanceId.2": "instance_name_2",
          UserData: "script",
          "UserData.Encoding": "base64",
          "InstanceType.1": "mini",
          "InstanceType.2": "small",
          "AccountingType.1": "2",
          "AccountingType.2": "1",
          NiftyIsBios: "false",
          "Tenancy.1": "all"
        }
      )

    assert expected ==
             Computing.start_instances(
               ["instance_name_1", "instance_name_2"],
               user_data: "script",
               user_data_encoding: "base64",
               accounting_types: ["2", "1"],
               instance_types: ["mini", "small"],
               nifty_is_bios: "false",
               tenancys: ["all"]
             )
  end
end
