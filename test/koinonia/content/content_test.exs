defmodule Koinonia.ContentTest do
  use Koinonia.DataCase

  alias Koinonia.{Account, Content, Repo}
  alias Koinonia.Content.PrayerRequest

  @valid_attrs %{
    "username" => "BuddyHolly",
    "email" => "sweater@weezer.com",
    "password" => "MaryTylerMoore"
  }
  test "build_prayer_request/0 returns a prayer_request changeset" do
    assert %Ecto.Changeset{data: %PrayerRequest{}} = Content.build_prayer_request()
  end

  test "build_prayer_request/1 returns a prayer_request with values applied" do
    {:ok, user} = Account.create_user(@valid_attrs)
    attrs = %{"title" => "PR Title", "body" => "PR Body", "user_id" => user.id}
    changeset = Content.build_prayer_request(attrs)
    assert changeset.params == attrs
  end

  test "create_prayer_request/1 returns a prayer_request for valid data" do
    {:ok, user} = Account.create_user(@valid_attrs)
    valid_attrs = %{"title" => "PR Title", "body" => "PR Body", "user_id" => user.id}

    assert {:ok, prayer_request} = Content.create_prayer_request(valid_attrs)
  end

  test "create_prayer_request/1 returns a changeset for invalid data" do
    invalid_attrs = %{}
    assert {:error, %Ecto.Changeset{}} = Content.create_prayer_request(invalid_attrs)
  end

  test "list_prayer_requests/0 returns all public prayers" do
    {:ok, user} = Account.create_user(@valid_attrs)

    Repo.insert(%PrayerRequest{
      title: "Prayer Request 1 Title",
      body: "Prayer Request 1 Body",
      is_private: false,
      user_id: user.id
    })

    Repo.insert(%PrayerRequest{
      title: "Prayer Request 2 Title",
      body: "Prayer Request 2 Body",
      is_private: true,
      user_id: user.id
    })

    [pr1 = %PrayerRequest{}] = Content.list_prayer_requests()

    assert pr1.title == "Prayer Request 1 Title"
    assert pr1.body == "Prayer Request 1 Body"
  end

  test "list_user_prayer_requests/1 returns all public prayers of given user" do
  end
end
