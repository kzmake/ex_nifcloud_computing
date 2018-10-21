defmodule ExNifcloud.Computing.Test do
  use ExUnit.Case, async: true

  doctest ExNifcloud.Computing

  alias ExNifcloud.Computing
  alias Test.ExNifclod.Computing.Helper

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
          UserDate: "user_data",
          UserDateEncoding: "",
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
               user_date: "user_data",
               user_date_encoding: "",
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
end
