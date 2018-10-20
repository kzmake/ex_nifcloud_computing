defmodule Test.ExNifclod.Computing.Helper do
  def build_query(action, params) do
    %ExNifcloud.Operation.Query{
      path: "/api/",
      params: params,
      service: :computing,
      action: action
    }
  end
end
