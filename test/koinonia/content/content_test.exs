defmodule Koinonia.ContentTest do
  use Koinonia.DataCase

  alias Koinonia.{Content, Repo}
  alias Koinonia.Content.PrayerRequest

  setup do
    Repo.insert(%PrayerRequest{title: "Prayer Request 1 Title", body: "Prayer Request 1 Body"})
    Repo.insert(%PrayerRequest{title: "Prayer Request 2 Title", body: "Prayer Request 2 Body"})
    :ok
  end

  test "list_prayer_requests/0 returns all public prayers" do
    [pr1 = %PrayerRequest{}, pr2 = %PrayerRequest{}] = Content.list_prayer_requests()

    assert pr1.title == "Prayer Request 1 Title"
    assert pr2.body == "Prayer Request 2 Body"
  end
end
