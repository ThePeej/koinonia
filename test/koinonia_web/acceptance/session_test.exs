defmodule KoinoniaWeb.Acceptance.SessionTest do
  use Koinonia.DataCase
  use Hound.Helpers

  hound_session()

  setup do
    alias Koinonia.Account

    valid_attrs = %{
      "username" => "BuddyHolly",
      "email" => "sweater@weezer.com",
      "password" => "MaryTylerMoore"
    }

    {:ok, _} = Account.create_user(valid_attrs)
    :ok
  end

  test "successful login for valid credentials" do
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

    assert current_path() == "/prayer_requests"

    message = find_element(:class, "alert-info") |> visible_text()

    assert message == "Login successful"
  end

  test "shows error message for invalid credentials" do
    navigate_to("/login")

    form = find_element(:id, "session-form")

    form
    |> find_within_element(:tag, "button")
    |> click()

    assert current_path() == "/login"
    message = find_element(:class, "alert-danger") |> visible_text()
    assert message == "Invalid username/password combination"
  end
end
