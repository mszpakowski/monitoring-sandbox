defmodule MonitoringSandbox.Repo do
  use Ecto.Repo,
    otp_app: :monitoring_sandbox,
    adapter: Ecto.Adapters.Postgres
end
