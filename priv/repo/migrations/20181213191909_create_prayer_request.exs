defmodule Koinonia.Repo.Migrations.CreatePrayerRequest do
  use Ecto.Migration

  def change do
    create table(:prayer_requests) do
      add :title, :string
      add :body, :string

      timestamps()
    end
  end
end
