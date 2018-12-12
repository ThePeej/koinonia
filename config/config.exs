# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :koinonia,
  ecto_repos: [Koinonia.Repo]

# Configures the endpoint
config :koinonia, KoinoniaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ULrDm22tPh4/Ekbs3+tlOlJjFzf+v/H/IOOHjLQUpCq3HPEnwxCMmJL4n8j6V9e2",
  render_errors: [view: KoinoniaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Koinonia.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Hound
config :hound, driver: "phantomjs"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
