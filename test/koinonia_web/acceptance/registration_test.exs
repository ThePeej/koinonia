defmodule KoinoniaWeb.Acceptance.RegistrationTest do
  use Koinonia.DataCase
  use Hound.Helpers

  hound_session()

  test "registers an account with valid data" do
    navigate_to("/register")

    form = find_element(:id, "registration-form")

    form
    |> find_within_element(:name, "registration[username]")
    |> fill_field("BuddyHolly")

    form
    |> find_within_element(:name, "registration[email]")
    |> fill_field("sweater@weezer.com")

    form
    |> find_within_element(:name, "registration[password]")
    |> fill_field("MaryTylerMoore")

    form
    |> find_within_element(:tag, "button")
    |> click

    assert current_path() == "/prayer_requests"

    message = find_element(:class, "alert") |> visible_text()

    assert message == "Registration successful"
  end

  test "shows error messages on invalid data" do
    navigate_to("/register")

    form = find_element(:id, "registration-form")

    form
    |> find_within_element(:tag, "button")
    |> click

    assert current_path() == "/register"

    message = find_element(:id, "form-error") |> visible_text()

    assert message == "Oops, something went wrong! Please check the errors below."
  end
end
