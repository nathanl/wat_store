# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :crap_store,
  ecto_repos: [CrapStore.Repo]

# Configures the endpoint
config :crap_store, CrapStoreWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UOr+X8u1JvCoC13EZ1sHN16gL+XI33uEhyKGbiKIjyDUD3jtvyYZ1FVx4T5gGjR+",
  render_errors: [view: CrapStoreWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: CrapStore.PubSub,
  live_view: [signing_salt: "YDchTdB3"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
