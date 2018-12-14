defmodule Koinonia.Content do
  @moduledoc false
  alias Koinonia.Content.PrayerRequest
  alias Koinonia.Repo

  def list_prayer_requests do
    PrayerRequest
    |> Repo.all()
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
