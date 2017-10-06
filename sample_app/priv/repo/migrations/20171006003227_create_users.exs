defmodule SampleApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :crypted_password, :string, null: false
      add :verified, :boolean, null: false, default: false

      timestamps()
    end
    create unique_index(:users, [:email])
  end
end
