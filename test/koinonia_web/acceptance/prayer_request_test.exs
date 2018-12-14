defmodule KoinoniaWeb.Acceptance.PrayerRequestTest do
  use Koinonia.DataCase
  use Hound.Helpers

  hound_session()

  setup do
    alias Koinonia.Content.PrayerRequest
    alias Koinonia.Repo

    Repo.insert(%PrayerRequest{title: "Prayer Request Title 1", body: "Prayer Request Body 1"})
    Repo.insert(%PrayerRequest{title: "Prayer Request Title 2", body: "Prayer Request Body 2"})
    :ok
  end

  test "presence of public prayer requests" do
    navigate_to("/prayer_requests")

    page_title = find_element(:css, ".page-title") |> visible_text()
    assert page_title == "Prayer Requests"

    [pr1, pr2] = find_all_elements(:css, ".prayer-request")

    pr_title =
      pr1
      |> find_within_element(:css, ".prayer-request-title")
      |> visible_text()

    pr_body =
      pr2
      |> find_within_element(:css, ".prayer-request-body")
      |> visible_text()

    assert pr_title == "Prayer Request Title 1"
    assert pr_body == "Prayer Request Body 2"
  end

  test "submit new prayer request" do
    navigate_to("/prayer_requests/new")

    form = find_element(:id, "prayer-request-form")

    form
    |> find_within_element(:name, "prayer-request[title]")
    |> fill_field("Prayer Request Title 3")

    form
    |> find_within_element(:name, "prayer-request[body]")
    |> fill_field("Prayer Request Body 3")

    form |> find_within_element(:tag, "button") |> click

    assert current_path() == "/prayer_request"

    message =
      find_element(:class, "alert")
      |> visible_text()

    assert message == "Registration successful"
    assert page_source() =~ "Prayer Request Title 3"
  end

  test "show error messages on invalid data" do
    navigate_to("prayer_request/new")

    form = find_element(:id, "prayer-request-form")
    form |> find_within_element(:tag, "button") |> click

    assert current_path() == "/prayer_request/new"

    message =
      find_element(:class, "form-error")
      |> visible_text()

    assert message == "Oops, something went wrong! Please check the errors below."
  end
end
