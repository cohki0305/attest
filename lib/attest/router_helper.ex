defmodule Attest.RouterHelper do
  defmacro __using__(_) do
    quote do
      import Attest.RouterHelper
    end
  end

  @doc """
  define routes for account authentication.
  first argument must be context of schema.
  """
  defmacro attest_for(basename) when is_atom(basename) do
    basename_module = basename
      |> Atom.to_string
      |> Phoenix.Naming.camelize
      |> String.to_atom

    quote do
      scope "/#{unquote(basename)}", unquote(basename_module), as: unquote(basename) do
        resources "/registers", RegistrationsController, only: [:new, :create],          singleton: true
        resources "/login",     SessionsController,      only: [:new, :create, :delete], singleton: true
      end
    end
  end
end
