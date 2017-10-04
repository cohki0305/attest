defmodule <%= inspect schema.repo %>.Migrations.Create<%= Macro.camelize(schema.table) %> do
  use Ecto.Migration

  def change do
    create table(:<%= schema.table %>) do
      add :email, :string, null: false
      add :crypted_password, :string, null: false
      add :verified, :boolean, null: false, default: false

      timestamps()
    end
    create unique_index(:<%= schema.table %>, [:email])
  end
end
