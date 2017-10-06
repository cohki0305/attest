defmodule Attest.Config do
  [
    :schema_name,
    :repo,
  ] |> Enum.each(fn key ->
         def unquote(key)() do
          Application.get_env(:attest, unquote(key))
         end
       end)
end
