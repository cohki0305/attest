defmodule <%= inspect context.web_module %>.<%= inspect context.alias %>.RegistrationsController do
  use <%= inspect context.web_module %>, :controller

  alias <%= inspect schema.module %>
  alias Attest.Contoller.RegistrationsContoller

  def new(conn, _params) do
    <%= inspect schema.alias %>
    |> RegistrationsContoller.new(conn)
  end

  def create(conn, %{<%= inspect schema.singular %> => <%= schema.singular %>_params}) do
    <%= inspect schema.alias %>
    |> RegistrationsContoller.create(conn, user_params)
  end
end
