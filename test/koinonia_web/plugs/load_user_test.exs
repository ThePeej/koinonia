defmodule KoinoniaWeb.Plugs.LoadUserTest do
  use KoinoniaWeb.ConnCase
  alias Koinonia.Account

  @valid_attrs %{
    "username" => "BuddyHolly",
    "email" => "sweater@weezer.com",
    "password" => "MaryTylerMoore"
  }

  test "fetch user from session on subsequent visit" do
    {:ok, user} = Account.create_user(@valid_attrs)

    conn = post build_conn(), "/login", %{"session" => @valid_attrs}

    conn = get(conn, "/")

    assert user.id == conn.assigns.current_user.id
  end
end
