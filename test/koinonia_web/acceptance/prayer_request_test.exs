defmodule KoinoniaWeb.Acceptance.PrayerRequestTest do
  use Koinonia.DataCase
  use Hound.Helpers

  hound_session()

  def login do
    valid_attrs = %{
      "username" => "BuddyHolly",
      "email" => "sweater@weezer.com",
      "password" => "MaryTylerMoore"
    }

    Koinonia.Account.create_user(valid_attrs)

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

  test "presence of public prayer requests" do
    alias Koinonia.Content.PrayerRequest
    alias Koinonia.Repo
    Repo.insert(%PrayerRequest{title: "Prayer Request Title 1", body: "Prayer Request Body 1"})
    Repo.insert(%PrayerRequest{title: "Prayer Request Title 2", body: "Prayer Request Body 2"})
    navigate_to("/prayer_requests")

    page_title = find_element(:css, ".page-title") |> visible_text()
    assert page_title == "Prayer Requests"

    [pr1, pr2] = find_all_elements(:css, ".prayer-request")

    pr_title =
      pr1
      |> find_within_element(:css, ".title")
      |> visible_text()

    pr_body =
      pr2
      |> find_within_element(:css, ".subtitle")
      |> visible_text()

    assert pr_title == "Prayer Request Title 1"
    assert pr_body == "Prayer Request Body 2"
  end

  test "submit new prayer request" do
    login()

    navigate_to("/prayer_requests/new")

    form = find_element(:id, "prayer-request-form")

    form
    |> find_within_element(:name, "prayer_request[title]")
    |> fill_field("Prayer Request Title 3")

    form
    |> find_within_element(:name, "prayer_request[body]")
    |> fill_field("Prayer Request Body 3")

    form |> find_within_element(:tag, "button") |> click

    assert current_path() == "/prayer_requests"

    message =
      find_element(:class, "alert")
      |> visible_text()

    assert message == "Prayer request shared successfully"
    assert page_source() =~ "Prayer Request Title 3"
  end

  test "show error messages on invalid data" do
    login()

    navigate_to("/prayer_requests/new")

    form = find_element(:id, "prayer-request-form")
    form |> find_within_element(:tag, "button") |> click

    assert find_element(:id, "prayer-request-form")

    message =
      find_element(:id, "form-error")
      |> visible_text()

    assert message == "Oops, something went wrong! Please check the errors below."
  end

  test "cannot submit new prayer request if not logged in" do
    navigate_to("/prayer_requests/new")

    assert current_path() == "/login"

    message =
      find_element(:class, "alert-info")
      |> visible_text()

    assert message == "You must be signed in."
  end
end
