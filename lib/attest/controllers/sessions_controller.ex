defmodule Attest.Contoller.SessionnsContoller do
  use Attest.Web, :controller

  def create(schema, conn, params, redirect_path \\ "/") do
    case schema |> Attest.Session.create(params) do
      {:ok, resource} ->
        conn
        |> put_session(:"current_#{resource_name(schema)}", resource.id)
        |> put_flash(:info, "ログインしました")
        |> redirect(to: redirect_path)
      :error ->
        conn
        |> put_flash(:error, "ログインに失敗しました")
        |> render("new.html")
    end
  end

  def delete(schema, conn, redirect_path \\ "/") do
    conn
    |> delete_session(:"current_#{resource_name(schema)}")
    |> put_flash(:info, "ログアウトしました")
    |> redirect(to: redirect_path)
  end

  def resource_name(schema) do
    Phoenix.Naming.resource_name(schema)
  end
end
