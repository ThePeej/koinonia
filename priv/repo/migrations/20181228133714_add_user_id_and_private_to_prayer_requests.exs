defmodule Koinonia.Repo.Migrations.AddUserIdAndPrivateToPrayerRequests do
  use Ecto.Migration

  def change do
    alter table(:prayer_requests) do
      add :is_private, :boolean
      add :user_id, references(:users, on_delete: :delete_all)
    end

    create index(:prayer_requests, [:user_id])
  end
end
