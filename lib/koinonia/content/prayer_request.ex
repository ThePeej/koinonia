defmodule Koinonia.Content.PrayerRequest do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "prayer_requests" do
    field :title, :string
    field :body, :string

    timestamps()
  end

  @doc false
  def changeset(prayer_request, attrs) do
    prayer_request
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
