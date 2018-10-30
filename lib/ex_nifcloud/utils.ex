defmodule ExNifcloud.Computing.Utils do
  @moduledoc false

  @service :computing

  # ---------------- #
  # Helper Functions #
  # ---------------- #

  def build_operation(opts, action) do
    opts
    |> Enum.flat_map(&format_param/1)
    |> generate_operation(action)
  end

  defp generate_operation(params, action) do
    %ExNifcloud.Operation.Query{
      path: "/api/",
      params:
        params
        |> filter_nil_params,
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

  defp format_param({:ip_address, value}) do
    format(value, prefix: "IpAddress")
  end

  defp format_param({:placement_availability_zone, value}) do
    format(value, prefix: "Placement.AvailabilityZone")
  end

  defp format_param({:user_data_encoding, value}) do
    format(value, prefix: "UserData.Encoding")
  end

  defp format_param({:nifty_is_bios, value}) do
    format(value, prefix: "NiftyIsBios")
  end

  defp format_param({key, value}) when is_atom(key) do
    prefix =
      key
      |> Atom.to_string()
      |> Macro.camelize()

    cond do
      String.last(prefix) == "s" ->
        format(value, prefix: String.slice(prefix, 0..-2))

      true ->
        format(value, prefix: prefix)
    end
  end

  defp format(value, kwargs) when is_binary(value) do
    [{String.to_atom(kwargs[:prefix]), value}]
  end

  defp format([value | _] = params, prefix: prefix) when is_list(params) and is_binary(value) do
    params
    |> Stream.with_index(1)
    |> Stream.map(fn {value, i} -> {value, Integer.to_string(i)} end)
    |> Stream.map(fn {value, i} -> {String.to_atom(prefix <> dot?(prefix) <> i), value} end)
    |> Enum.to_list()
  end

  defp format([nested | _] = params, kwargs) when is_map(nested) do
    params
    |> Enum.map(&Map.to_list/1)
    |> format(kwargs)
  end

  defp format([nested | _] = params, prefix: pre) when is_list(nested) do
    params
    |> Stream.with_index(1)
    |> Stream.map(fn {params, i} -> {params, Integer.to_string(i)} end)
    |> Stream.flat_map(fn {params, i} ->
      format(params, prefix: pre <> dot?(pre) <> i)
    end)
    |> Enum.to_list()
  end

  defp format([param | _] = params, prefix: pre) when is_tuple(param) do
    params
    |> Stream.map(fn {key, values} -> {Macro.camelize(Atom.to_string(key)), values} end)
    |> Stream.flat_map(fn {key, values} ->
      format(values, prefix: pre <> dot?(pre) <> key)
    end)
    |> Enum.to_list()
  end

  defp dot?(""), do: ""
  defp dot?(_), do: "."
end
