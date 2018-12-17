defmodule KoinoniaWeb.RegistrationController do
  use KoinoniaWeb, :controller
  alias Koinonia.Account

  def new(conn, _) do
    changeset = Account.build_user()
    render(conn, "new.html", changeset: changeset)
  end
end
