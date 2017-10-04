defmodule <%= inspect schema.module %> do
  use Ecto.Schema
  import Ecto.Changeset

  schema <%= inspect schema.table %> do
    field :email, :string
    field :password, :string, virtual: true
    field :crypted_password, :string
    field :verified, :boolean

    timestamps()
  end

  def changeset(%<%= inspect schema.alias %>{} = <%= schema.singular %>, attrs) do
    <%= schema.singular %>
    |> cast(params, [:email, :password, :verified])
    |> change(%{verified: false})
    |> validate_required([:email, :password, :verified])
    |> update_change(:email, &String.downcase/1)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
  end

  def create(changeset, repo) do
    changeset
    |> put_change(:crypted_password, hashed_password(changeset.params["password"]))
    |> repo.insert()
  end

  defp hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end
