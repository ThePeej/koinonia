defmodule KoinoniaWeb.PrayerRequestController do
  use KoinoniaWeb, :controller
  alias Koinonia.Content

  def index(conn, _params) do
    prayer_requests = Content.list_prayer_requests()
    render(conn, "index.html", prayer_requests: prayer_requests)
  end
end
