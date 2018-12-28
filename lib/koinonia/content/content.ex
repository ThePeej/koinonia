defmodule Koinonia.Content do
  @moduledoc false
  import Ecto.Query, only: [from: 2]
  alias Koinonia.Content.PrayerRequest
  alias Koinonia.Repo

  def list_prayer_requests do
    query = from(p in PrayerRequest, where: p.is_public)
    Repo.all(query)
  end

  def build_prayer_request(attrs \\ %{}) do
    %PrayerRequest{}
    |> PrayerRequest.changeset(attrs)
  end

  def create_prayer_request(attrs) do
    attrs
    |> build_prayer_request
    |> Repo.insert()
  end
end
