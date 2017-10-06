defmodule Attest.Session do
  def create(schema, %{"email" => email, "password" => password}, repo \\ Attest.Config.repo) do
    resource = schema |> repo.get_by(email: String.downcase(email))
    case authenticate(resource, password) do
      true -> {:ok, resource}
      _    -> :error
    end
  end

  defp authenticate(resource, password) do
    case resource do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, resource.crypted_password)
    end
  end
end
