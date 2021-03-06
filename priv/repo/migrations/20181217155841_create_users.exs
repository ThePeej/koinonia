defmodule Koinonia.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext"

    create table(:users) do
      add :username, :string
      add :email, :citext
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
