defmodule <%= inspect schema.module %> do
  use Ecto.Schema
  import Ecto.Changeset
  alias <%= inspect schema.module %>

  schema <%= inspect schema.table %> do
    field :email, :string
    field :password, :string, virtual: true
    field :crypted_password, :string
    field :verified, :boolean

    timestamps()
  end

  def changeset(%<%= inspect schema.alias %>{} = <%= schema.singular %>, attrs \\ %{}) do
    <%= schema.singular %>
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> update_change(:email, &String.downcase/1)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
  end
end
