defmodule ExNifcloud.Computing do
  @moduledoc """
  Computing(Nifcloud) のオペレーション群

  ## リソース

  - ExNifcloud.Computing.Instances
  """

  @service :computing

  # ---------------- #
  # Helper Functions #
  # ---------------- #

  def build_request(opts, action) do
    opts
    |> Enum.flat_map(&format_param/1)
    |> request(action)
  end

  defp request(params, action) do
    action_string =
      action
      |> Atom.to_string()
      |> Macro.camelize()

    %ExNifcloud.Operation.Query{
      path: "/api/",
      params:
        params
        |> filter_nil_params
        |> Map.put(:Action, action_string),
      service: @service,
      action: action
    }
  end

  defp filter_nil_params(opts) do
    opts
    |> Enum.reject(fn {_key, value} -> value == nil end)
    |> Enum.into(%{})
  end

  # ---------------- #
  # Format Functions #
  # ---------------- #

  defp format_param({:instance_ids, instance_ids}) do
    instance_ids
    |> format(prefix: "InstanceId")
  end

  defp format(params, prefix: prefix) when is_list(params) do
    params
    |> Stream.with_index(1)
    |> Stream.map(fn {value, i} -> {value, Integer.to_string(i)} end)
    |> Stream.map(fn {value, i} -> {String.to_atom(prefix <> dot?(prefix) <> i), value} end)
    |> Enum.to_list()
  end

  defp dot?(""), do: ""
  defp dot?(_), do: "."
end
