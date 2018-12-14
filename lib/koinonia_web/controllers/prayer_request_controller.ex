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

  def create(conn, %{"prayer_request" => prayer_request_params}) do
    case Content.create_prayer_request(prayer_request_params) do
      {:ok, _prayer_request} ->
        conn
        |> put_flash(:info, "Prayer request shared successfully")
        |> redirect(to: Routes.prayer_request_path(conn, :index))

      {:error, changeset} ->
        conn
        |> render(:new, changeset: changeset)
    end
  end
end
