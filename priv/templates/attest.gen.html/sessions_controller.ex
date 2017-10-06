defmodule <%= inspect context.web_module %>.<%= inspect context.alias %>.SessionsController do
  use <%= inspect context.web_module %>, :controller
  alias <%= inspect schema.module %>
  alias Attest.Contoller.SessionnsContoller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
    <%= inspect schema.alias %>
    |> SessionnsContoller.create(conn, session_params)
  end

  def delete(conn, _params) do
    <%= inspect schema.alias %>
    |> SessionnsContoller.delete(conn)
  end
end
