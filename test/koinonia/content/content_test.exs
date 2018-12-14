defmodule Koinonia.ContentTest do
  use Koinonia.DataCase

  alias Koinonia.{Content, Repo}
  alias Koinonia.Content.PrayerRequest

  test "build_prayer_request/0 returns a prayer_request changeset" do
    assert %Ecto.Changeset{data: %PrayerRequest{}} = Content.build_prayer_request()
  end

  test "build_prayer_request/1 returns a prayer_request with values applied do" do
    attrs = %{"title" => "PR Title", "body" => "PR Body"}
    changeset = Content.build_prayer_request(attrs)
    assert changeset.params == attrs
  end

  test "list_prayer_requests/0 returns all public prayers" do
    Repo.insert(%PrayerRequest{title: "Prayer Request 1 Title", body: "Prayer Request 1 Body"})
    Repo.insert(%PrayerRequest{title: "Prayer Request 2 Title", body: "Prayer Request 2 Body"})
    [pr1 = %PrayerRequest{}, pr2 = %PrayerRequest{}] = Content.list_prayer_requests()

    assert pr1.title == "Prayer Request 1 Title"
    assert pr2.body == "Prayer Request 2 Body"
  end
end
