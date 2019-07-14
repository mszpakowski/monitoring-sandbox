defmodule MonitoringSandbox.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = default_children() ++ maybe_simulator()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MonitoringSandbox.Supervisor]
    Confex.resolve_env!(:my_app)
    Prometheus.Registry.register_collector(:prometheus_process_collector)
    MonitoringSandbox.Instrumenters.Phoenix.setup()
    MonitoringSandbox.Instrumenters.Pipeline.setup()
    MonitoringSandbox.Instrumenters.Ecto.setup()
    MonitoringSandbox.Instrumenters.PrometheusExporter.setup()
    MonitoringSandbox.Instrumenters.Cats.setup()
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MonitoringSandboxWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp default_children do
    [MonitoringSandbox.Repo, MonitoringSandboxWeb.Endpoint]
  end

  defp maybe_simulator() do
    if Confex.fetch_env!(:monitoring_sandbox, MonitoringSandboxWeb.RequestSimulator)[:enabled?],
      do: [{MonitoringSandboxWeb.RequestSimulator, 10_000}],
      else: []
  end
end
