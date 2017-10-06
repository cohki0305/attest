defmodule <%= inspect context.web_module %>.<%= inspect context.alias %>.RegistrationsController do
  use <%= inspect context.web_module %>, :controller

  alias <%= inspect schema.module %>

  def new(conn, _params) do
    changeset = <%= inspect schema.alias %>.changeset(%<%= inspect schema.alias %>{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{<%= inspect schema.singular %> => <%= schema.singular %>_params}) do
    changeset = <%= inspect schema.alias %>.changeset(%<%= inspect schema.alias %>{}, <%= schema.singular %>_params)
    case Attest.Registration.create(changeset, Repo) do
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
