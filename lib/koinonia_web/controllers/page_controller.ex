defmodule KoinoniaWeb.PageController do
  use KoinoniaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
