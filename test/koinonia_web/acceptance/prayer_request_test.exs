defmodule KoinoniaWeb.Acceptance.PrayerRequestTest do
  use Koinonia.DataCase
  use Hound.Helpers

  hound_session()

  setup do
    alias Koinonia.Content.PrayerRequest
    alias Koinonia.Repo

    Repo.insert(%PrayerRequest{title: "Prayer Request 1 Title", body: "Prayer Request 1 Body"})
    Repo.insert(%PrayerRequest{title: "Prayer Request 2 Title", body: "Prayer Request 2 Body"})
    :ok
  end

  test "presence of public prayer requests" do
    navigate_to("/prayer_requests")

    page_title = find_element(:css, ".page-title") |> visible_text()
    assert page_title == "Prayer Requests"

    pr = find_element(:css, ".prayer-request")

    pr_title =
      pr
      |> find_within_element(:css, ".prayer-request-title")
      |> visible_text()

    pr_body =
      pr
      |> find_within_element(:css, ".prayer-request-body")
      |> visible_text()

    assert pr_title == "Prayer Request 1 Title"
    assert pr_body == "Prayer Request 1 Body"
  end
end
