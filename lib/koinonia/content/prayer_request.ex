defmodule Koinonia.Content.PrayerRequest do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "prayer_requests" do
    field :title, :string
    field :body, :string
    field :is_private, :boolean
    belongs_to :user, Koinonia.Account.User

    timestamps()
  end

  @doc false
  def changeset(prayer_request, attrs) do
    prayer_request
    |> cast(attrs, [:title, :body, :is_private, :user_id])
    |> validate_required([:title, :body, :is_private, :user_id])
  end
end
