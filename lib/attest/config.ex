defmodule Attest.Config do
  @moduledoc """
    Get value from config
  """

  [
    :schema_name,
    :repo,
    :resources,
    :base,
  ] |> Enum.each(fn key ->
         def unquote(key)() do
          Application.get_env(:attest, unquote(key))
         end
       end)
end
