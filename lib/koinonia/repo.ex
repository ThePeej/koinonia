defmodule Koinonia.Repo do
  use Ecto.Repo,
    otp_app: :koinonia,
    adapter: Ecto.Adapters.Postgres
end
