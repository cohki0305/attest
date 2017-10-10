defmodule Attest.Helpers do
  alias Attest.Config
  import Plug.Conn


  Config.resources |> Enum.each(fn {context, schema} ->

    context_str = context |> Atom.to_string
    context_module = context_str |> Phoenix.Naming.camelize

    schema_str = schema |> Atom.to_string
    schema_module = schema_str |> Phoenix.Naming.camelize

    def unquote(:"current_#{schema_str}")(conn, repo \\ Attest.Config.repo) do
      id = get_session(conn, unquote(:"current_#{schema_str}"))
      if id, do: unquote(:"#{Config.base}.#{context_module}.#{schema_module}") |> repo.get(id)
    end

    def unquote(:"#{schema_str}_logged_in?")(conn) do
      account = unquote(:"current_#{schema_str}")(conn)
      !!account
    end
  end)
end
