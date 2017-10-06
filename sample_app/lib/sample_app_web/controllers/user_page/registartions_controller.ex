defmodule SampleAppWeb.UserPage.RegistrationsController do
  use SampleAppWeb, :controller

  alias SampleApp.UserPage.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    case Attest.Registration.create_resource(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "ようこそ" <> changeset.params["email"])
        |> redirect(to: redirect_path_after_registration(conn))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "アカウントを作成できませんでした")
        |> render("new.html", changeset: changeset)
    end
  end

  defp redirect_path_after_registration(conn) do
    page_path(conn, :index)
  end
end
