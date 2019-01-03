defmodule KoinoniaWeb.Acceptance.PrayerRequestUpdateDeleteTest do
  use Koinonia.DataCase
  use Hound.Helpers

  hound_session()

  @valid_attrs1 %{
    "username" => "BuddyHolly",
    "email" => "sweater@weezer.com",
    "password" => "MaryTylerMoore"
  }

  @valid_attrs2 %{
    "username" => "CharlieBrown",
    "email" => "PigPen@Peanuts.com",
    "password" => "Snoopy"
  }

  defp login do
    navigate_to("/login")

    form = find_element(:id, "session-form")

    form
    |> find_within_element(:name, "session[username]")
    |> fill_field("BuddyHolly")

    form
    |> find_within_element(:name, "session[password]")
    |> fill_field("MaryTylerMoore")

    form
    |> find_within_element(:tag, "button")
    |> click()
  end

  defp page_reload?(page_path, retries \\ 5)

  defp page_reload?(page_path, 0) do
    page_reload?(page_path)
  end

  defp page_reload?(page_path, retries) do
    case current_path() == page_path do
      true ->
        true

      false ->
        :timer.sleep(10)
        page_reload?(page_path, retries - 1)
    end
  end

  test "user can edit their prayer request" do
    alias Koinonia.Content
    {:ok, user1} = Koinonia.Account.create_user(@valid_attrs1)

    {:ok, pr1} =
      Content.create_prayer_request(%{
        title: "Prayer Request Title 1",
        body: "Prayer Request Body 1",
        is_public: false,
        user_id: user1.id
      })

    login()

    navigate_to("/prayer_requests/#{pr1.id}/edit")

    form = find_element(:id, "prayer-request-form")

    existing_title =
      form
      |> find_within_element(:name, "prayer_request[title]")
      |> attribute_value("value")

    assert existing_title == "Prayer Request Title 1"

    form
    |> find_within_element(:name, "prayer_request[title]")
    |> fill_field("Edited Prayer Request Title 1")

    form
    |> find_within_element(:name, "prayer_request[body]")
    |> fill_field("Edited Prayer Request Body 1")

    form
    |> find_within_element(:id, "prayer_request_is_public")
    |> click

    form |> find_within_element(:tag, "button") |> click

    assert current_path() == "/prayer_requests/#{pr1.id}"

    message =
      find_element(:class, "alert")
      |> visible_text()

    assert message == "Prayer request updated successfully"
    assert page_source() =~ "Edited Prayer Request Title 1"
    assert page_source() =~ "Edited Prayer Request Body 1"
    assert page_source() =~ "Public"
  end

  test "user cannot edit another user's prayer request" do
    alias Koinonia.Content
    {:ok, _user1} = Koinonia.Account.create_user(@valid_attrs1)
    {:ok, user2} = Koinonia.Account.create_user(@valid_attrs2)

    {:ok, pr2} =
      Content.create_prayer_request(%{
        title: "Prayer Request Title 2",
        body: "Prayer Request Body 2",
        is_public: false,
        user_id: user2.id
      })

    login()

    navigate_to("/prayer_requests/#{pr2.id}/edit")

    assert current_path() == "/prayer_requests"

    message =
      find_element(:class, "alert-danger")
      |> visible_text()

    assert message == "You can only update and/or delete your own prayer requests"
  end

  test "user can delete their prayer request" do
    alias Koinonia.Content
    {:ok, user1} = Koinonia.Account.create_user(@valid_attrs1)

    {:ok, pr1} =
      Content.create_prayer_request(%{
        title: "Prayer Request Title 1",
        body: "Prayer Request Body 1",
        is_public: true,
        user_id: user1.id
      })

    login()

    navigate_to("/prayer_requests")

    assert page_source() =~ "Prayer Request Title 1"

    navigate_to("/prayer_requests/#{pr1.id}")

    find_element(:id, "delete-prayer-request") |> click()

    assert page_reload?("/prayer_requests", ~r/10/)

    message =
      find_element(:class, "alert")
      |> visible_text()

    assert message == "Prayer request deleted successfully"
    refute page_source() =~ "Prayer Request Title 1"
  end

  test "user cannot delete another user's prayer request" do
    alias Koinonia.Content
    {:ok, _user1} = Koinonia.Account.create_user(@valid_attrs1)
    {:ok, user2} = Koinonia.Account.create_user(@valid_attrs2)

    {:ok, pr2} =
      Content.create_prayer_request(%{
        title: "Prayer Request Title 2",
        body: "Prayer Request Body 2",
        is_public: true,
        user_id: user2.id
      })

    login()

    navigate_to("/prayer_requests")

    assert page_source() =~ "Prayer Request Title 2"

    navigate_to("/prayer_requests/#{pr2.id}")

    find_element(:id, "delete-prayer-request") |> click()

    assert page_reload?("/prayer_requests", ~r/10/)

    message =
      find_element(:class, "alert-danger")
      |> visible_text()

    assert message == "You can only update and/or delete your own prayer requests"
    assert page_source() =~ "Prayer Request Title 2"
  end
end
