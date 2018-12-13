defmodule Koinonia.Content do
  @moduledoc false
  alias Koinonia.Content.PrayerRequest
  alias Koinonia.Repo

  def list_prayer_requests do
    PrayerRequest
    |> Repo.all()
  end
end
