defmodule Koinonia.Repo.Migrations.AddUserIdAndPublicToPrayerRequests do
  use Ecto.Migration

  def change do
    alter table(:prayer_requests) do
      add :is_public, :boolean
      add :user_id, references(:users, on_delete: :delete_all)
    end

    create index(:prayer_requests, [:user_id])
  end
end
