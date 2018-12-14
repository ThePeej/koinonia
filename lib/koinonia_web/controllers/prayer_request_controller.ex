defmodule KoinoniaWeb.PrayerRequestController do
  use KoinoniaWeb, :controller
  alias Koinonia.Content

  def index(conn, _params) do
    prayer_requests = Content.list_prayer_requests()
    render(conn, "index.html", prayer_requests: prayer_requests)
  end

  def new(conn, _) do
    changeset = Content.build_prayer_request()
    render(conn, "new.html", changeset: changeset)
  end
end
