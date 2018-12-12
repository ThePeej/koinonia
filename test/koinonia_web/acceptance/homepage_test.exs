defmodule Koinonia.HomepageTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session()

  test "presence of public prayers requests" do
    navigate_to("/")

    assert page_source() =~ "Public Prayer Requests"
  end
end
