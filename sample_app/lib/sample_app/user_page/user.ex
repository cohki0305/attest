defmodule SampleApp.UserPage.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias SampleApp.UserPage.User

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :crypted_password, :string
    field :verified, :boolean

    timestamps()
  end

  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> update_change(:email, &String.downcase/1)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
  end
end
