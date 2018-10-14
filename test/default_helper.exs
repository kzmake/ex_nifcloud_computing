defmodule Test.ExNifclod.Computing.Helper do
  def build_query(action, params) do
    action_string =
      action
      |> Atom.to_string()
      |> Macro.camelize()

    %ExNifcloud.Operation.Query{
      path: "/api/",
      params:
        params
        |> Map.merge(%{Action: action_string}),
      service: :computing,
      action: action
    }
  end
end
