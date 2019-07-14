# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :monitoring_sandbox,
  ecto_repos: [MonitoringSandbox.Repo],
  grafana_password: {:system, "GRAFANA_PASSWORD"}

config :monitoring_sandbox, MonitoringSandboxWeb.RequestSimulator, enabled?: false

# Configures the endpoint
config :monitoring_sandbox, MonitoringSandboxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Ksqjw+6KstkwYdaeF9HSy/j6lL72BdN9k1HK6ZeLhwXHmJhblEaROlLLu2AavrHD",
  render_errors: [view: MonitoringSandboxWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: MonitoringSandbox.PubSub, adapter: Phoenix.PubSub.PG2],
  instrumenters: [MonitoringSandbox.Instrumenters.Phoenix]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :prometheus, MonitoringSandbox.Instrumenters.Phoenix,
  controller_call_labels: [:controller, :action],
  duration_buckets: [
    10,
    25,
    50,
    100,
    250,
    500,
    1000,
    2500,
    5000,
    10_000,
    25_000,
    50_000,
    100_000,
    250_000,
    500_000,
    1_000_000,
    2_500_000,
    5_000_000,
    10_000_000
  ],
  registry: :default,
  duration_unit: :microseconds

config :prometheus, MonitoringSandbox.Instrumenters.Pipeline,
  labels: [:status_class, :status_code, :method, :host, :scheme, :request_path],
  duration_buckets: [
    10,
    100,
    1_000,
    10_000,
    100_000,
    300_000,
    500_000,
    750_000,
    1_000_000,
    1_500_000,
    2_000_000,
    3_000_000
  ],
  registry: :default,
  duration_unit: :microseconds

config :monitoring_sandbox, MonitoringSandbox.Repo,
  adapter: Ecto.Adapters.Postgres,
  loggers: [MonitoringSandbox.Instrumenters.Ecto]
