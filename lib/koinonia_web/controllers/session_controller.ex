defmodule KoinoniaWeb.SessionController do
  use KoinoniaWeb, :controller
  alias Koinonia.Account

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => session_params}) do
    case Account.get_user_by_credentials(session_params) do
      :error ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")

      user ->
        path = get_session(conn, :intending_to_visit) || Routes.prayer_request_path(conn, :index)

        conn
        |> assign(:current_user, user)
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> put_flash(:info, "Login successful")
        |> redirect(to: path)
    end
  end

  def delete(conn, _) do
    conn
    |> clear_session()
    |> put_flash(:info, "You have been logged out.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
