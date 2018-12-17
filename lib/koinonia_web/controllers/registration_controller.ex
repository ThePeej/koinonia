defmodule KoinoniaWeb.RegistrationController do
  use KoinoniaWeb, :controller
  alias Koinonia.Account

  def new(conn, _) do
    changeset = Account.build_user()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"registration" => registration_params}) do
    case Account.create_user(registration_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Registration successful")
        |> redirect(to: Routes.prayer_request_path(conn, :index))

      {:error, changeset} ->
        conn
        |> render(:new, changeset: changeset)
    end
  end
end
