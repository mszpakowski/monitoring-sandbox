# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :monitoring_sandbox,
  ecto_repos: [MonitoringSandbox.Repo]

# Configures the endpoint
config :monitoring_sandbox, MonitoringSandboxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Ksqjw+6KstkwYdaeF9HSy/j6lL72BdN9k1HK6ZeLhwXHmJhblEaROlLLu2AavrHD",
  render_errors: [view: MonitoringSandboxWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: MonitoringSandbox.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
