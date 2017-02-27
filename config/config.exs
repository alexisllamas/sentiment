# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :etlicus,
  ecto_repos: [Etlicus.Repo]

# Configures the endpoint
config :etlicus, Etlicus.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "al9d7FCL1MPETfdM9MfWDC3aUeIlcpC4TCd8ChnWfy16fVLxOPwequPX2YbYUSB1",
  render_errors: [view: Etlicus.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Etlicus.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
