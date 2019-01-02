defmodule Koinonia.ContentTest do
  use Koinonia.DataCase

  alias Koinonia.{Account, Content, Repo}
  alias Koinonia.Content.PrayerRequest

  @valid_user_attrs %{
    "username" => "BuddyHolly",
    "email" => "sweater@weezer.com",
    "password" => "MaryTylerMoore"
  }
  test "build_prayer_request/0 returns a prayer_request changeset" do
    assert %Ecto.Changeset{data: %PrayerRequest{}} = Content.build_prayer_request()
  end

  test "build_prayer_request/1 returns a prayer_request with values applied" do
    {:ok, user} = Account.create_user(@valid_user_attrs)

    valid_attrs = %{
      "title" => "PR Title",
      "body" => "PR Body",
      "is_public" => true,
      "user_id" => user.id
    }

    changeset = Content.build_prayer_request(valid_attrs)
    assert changeset.params == valid_attrs
  end

  test "create_prayer_request/1 returns a prayer_request for valid data" do
    {:ok, user} = Account.create_user(@valid_user_attrs)

    valid_attrs = %{
      "title" => "PR Title",
      "body" => "PR Body",
      "is_public" => true,
      "user_id" => user.id
    }

    assert {:ok, prayer_request} = Content.create_prayer_request(valid_attrs)
  end

  test "create_prayer_request/1 returns a changeset for invalid data" do
    invalid_attrs = %{}
    assert {:error, %Ecto.Changeset{}} = Content.create_prayer_request(invalid_attrs)
  end

  test "list_prayer_requests/0 returns all public prayers" do
    {:ok, user} = Account.create_user(@valid_user_attrs)

    Repo.insert(%PrayerRequest{
      title: "Prayer Request 1 Title",
      body: "Prayer Request 1 Body",
      is_public: false,
      user_id: user.id
    })

    Repo.insert(%PrayerRequest{
      title: "Prayer Request 2 Title",
      body: "Prayer Request 2 Body",
      is_public: true,
      user_id: user.id
    })

    [pr2 = %PrayerRequest{}] = Content.list_prayer_requests()

    assert pr2.title == "Prayer Request 2 Title"
    assert pr2.body == "Prayer Request 2 Body"
  end

  test "get_prayer_request/1" do
    {:ok, user} = Account.create_user(@valid_user_attrs)

    valid_attrs = %{
      "title" => "PR Title",
      "body" => "PR Body",
      "is_public" => true,
      "user_id" => user.id
    }

    {:ok, prayer_request} = Content.create_prayer_request(valid_attrs)

    assert prayer_request == Content.get_prayer_request(prayer_request.id)
  end

  test "get_prayer_requests_by_user/1 returns all public prayers of given user" do
    valid_user_attrs1 = %{
      "username" => "BuddyHolly",
      "email" => "sweater@weezer.com",
      "password" => "MaryTylerMoore"
    }

    valid_user_attrs2 = %{
      "username" => "CharlieBrown",
      "email" => "pigpen@peanuts.com",
      "password" => "Snoopy"
    }

    {:ok, user1} = Account.create_user(valid_user_attrs1)
    {:ok, user2} = Account.create_user(valid_user_attrs2)

    Repo.insert(%PrayerRequest{
      title: "Prayer Request 1 Title",
      body: "Prayer Request 1 Body",
      is_public: false,
      user_id: user1.id
    })

    Repo.insert(%PrayerRequest{
      title: "Prayer Request 2 Title",
      body: "Prayer Request 2 Body",
      is_public: true,
      user_id: user1.id
    })

    Repo.insert(%PrayerRequest{
      title: "Prayer Request 3 Title",
      body: "Prayer Request 3 Body",
      is_public: false,
      user_id: user2.id
    })

    Repo.insert(%PrayerRequest{
      title: "Prayer Request 4 Title",
      body: "Prayer Request 4 Body",
      is_public: true,
      user_id: user2.id
    })

    [pr2 = %PrayerRequest{}] = Content.get_prayer_requests_by_user(user1.id)

    assert pr2.title == "Prayer Request 2 Title"
  end

  test "change_prayer_request/1 returns a prayer_request changeset" do
    valid_user_attrs1 = %{
      "username" => "BuddyHolly",
      "email" => "sweater@weezer.com",
      "password" => "MaryTylerMoore"
    }

    {:ok, user1} = Account.create_user(valid_user_attrs1)

    {:ok, prayer_request} =
      Repo.insert(%PrayerRequest{
        title: "Prayer Request 1 Title",
        body: "Prayer Request 1 Body",
        is_public: false,
        user_id: user1.id
      })

    assert %Ecto.Changeset{} = Content.change_prayer_request(prayer_request)
  end

  test "update_prayer_request/1 with valid data updates the prayer request" do
    valid_user_attrs1 = %{
      "username" => "BuddyHolly",
      "email" => "sweater@weezer.com",
      "password" => "MaryTylerMoore"
    }

    {:ok, user1} = Account.create_user(valid_user_attrs1)

    {:ok, prayer_request} =
      Repo.insert(%PrayerRequest{
        title: "Prayer Request 1 Title",
        body: "Prayer Request 1 Body",
        is_public: false,
        user_id: user1.id
      })

    updated_attrs = %{
      title: "Edited Prayer Request 1 Title",
      body: "Edited Prayer Request 1 Body",
      is_public: true,
      user_id: user1.id
    }

    assert {:ok, %PrayerRequest{} = prayer_request} =
             Content.update_prayer_request(prayer_request, updated_attrs)

    assert prayer_request.title == "Edited Prayer Request 1 Title"
    assert prayer_request.body == "Edited Prayer Request 1 Body"
    assert prayer_request.is_public
  end

  test "delete_prayer_request/1 deletes the prayer request" do
    valid_user_attrs1 = %{
      "username" => "BuddyHolly",
      "email" => "sweater@weezer.com",
      "password" => "MaryTylerMoore"
    }

    {:ok, user1} = Account.create_user(valid_user_attrs1)

    {:ok, prayer_request} =
      Repo.insert(%PrayerRequest{
        title: "Prayer Request 1 Title",
        body: "Prayer Request 1 Body",
        is_public: false,
        user_id: user1.id
      })

    assert {:ok, %PrayerRequest{}} = Content.delete_prayer_request(prayer_request)
    assert Content.get_prayer_request(prayer_request.id) == nil
  end
end
