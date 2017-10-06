defmodule SampleAppWeb.UserPage.SessionsController do
  use SampleAppWeb, :controller
  alias SampleApp.UserPage.User
  alias Attest.Contoller.SessionnsContoller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
    User
    |> SessionnsContoller.create(conn, session_params)
  end

  def delete(conn, _params) do
    User
    |> SessionnsContoller.delete(conn)
  end
end
