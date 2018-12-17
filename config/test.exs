use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :koinonia, KoinoniaWeb.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :koinonia, Koinonia.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("POSTGRES_USER") || "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "postgres",
  database: System.get_env("POSTGRES_DB") || "koinonia_test",
  hostname: System.get_env("POSTGRES_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure Bcrypt for faster testing
config :bcrypt_elixir, :log_rounds, 4
