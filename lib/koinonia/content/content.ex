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

  def change_prayer_request(%PrayerRequest{} = prayer_request) do
    PrayerRequest.changeset(prayer_request, %{})
  end

  def update_prayer_request(%PrayerRequest{} = prayer_request, attrs) do
    prayer_request
    |> PrayerRequest.changeset(attrs)
    |> Repo.update()
  end

  def get_prayer_request(id) do
    PrayerRequest
    |> Repo.get(id)
  end

  def load_prayer_request_user(prayer_request) do
    prayer_request
    |> Repo.preload([:user])
  end

  def get_prayer_requests_by_user(id) do
    query =
      from(
        p in PrayerRequest,
        where: p.is_public,
        where: p.user_id == ^id
      )

    Repo.all(query)
  end
end
