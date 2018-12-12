defmodule KoinoniaWeb.PageControllerTest do
  use KoinoniaWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Public Prayer Requests"
  end
end
