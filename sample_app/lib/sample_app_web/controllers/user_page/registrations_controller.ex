defmodule SampleAppWeb.UserPage.RegistrationsController do
  use SampleAppWeb, :controller

  alias SampleApp.UserPage.User
  alias Attest.Contoller.RegistrationsContoller

  def new(conn, _params) do
    User
    |> RegistrationsContoller.new(conn)
  end

  def create(conn, %{"user" => user_params}) do
    User
    |> RegistrationsContoller.create(conn, user_params)
  end
end
