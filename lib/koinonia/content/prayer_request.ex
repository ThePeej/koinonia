defmodule Koinonia.Content.PrayerRequest do
  @moduledoc false
  use Ecto.Schema

  schema "prayer_requests" do
    field :title, :string
    field :body, :string

    timestamps()
  end
end
