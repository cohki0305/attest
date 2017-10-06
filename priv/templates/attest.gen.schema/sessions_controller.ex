defmodule <%= inspect context.web_module %>.<%= inspect context.alias %>.SessionsController do
  use <%= inspect context.web_module %>, :controller
  alias <%= inspect schema.module %>

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
    case <%= inspect schema.alias %> |> Attest.Session.create(session_params) do
      {:ok, <%= schema.singular %>} ->
        conn
        |> put_session(:current_<%= schema.singular %>, <%= schema.singular %>.id)
        |> put_flash(:info, "ログインしました")
        |> redirect(to: redirect_path_after_login(conn))
      :error ->
        conn
        |> put_flash(:error, "ログインに失敗しました")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_<%= schema.singular %>)
    |> put_flash(:info, "ログアウトしました")
    |> redirect(to: redirect_path_after_logout(conn))
  end

  defp redirect_path_after_login(conn) do
    page_path(conn, :index)
  end

  defp redirect_path_after_logout(conn) do
    page_path(conn, :index)
  end
end
