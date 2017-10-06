defmodule Attest.RouterHelper do
  defmacro __using__(_) do
    quote do
      import Attest.RouterHelper
    end
  end

  defmacro attest_for(resource) when is_atom(resource) do
    quote do
      scope "/#{unquote(resource)}_page", unquote("#{resource}_page" |> Phoenix.Naming.camelize() |> String.to_atom()) do
        resources "/registers", RegistrationsController, only: [:new, :create], singleton: true
      end
    end
  end
end
