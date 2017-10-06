defmodule Attest.Contoller.RegistrationsContoller do
  use Attest.Web, :controller

  def new(schema, conn) do
    changeset = struct(schema) |> schema.changeset
    render(conn, "new.html", changeset: changeset)
  end

  def create(schema, conn, params, redirect_path \\ "/") do
    changeset = struct(schema) |> schema.changeset(params)
    case Attest.Registration.create_resource(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "ようこそ" <> changeset.params["email"])
        |> redirect(to: redirect_path)
      {:error, changeset} ->
        conn
        |> put_flash(:error, "アカウントを作成できませんでした")
        |> render("new.html", changeset: changeset)
    end
  end
end
