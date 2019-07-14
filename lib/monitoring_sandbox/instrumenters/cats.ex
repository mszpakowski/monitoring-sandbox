defmodule MonitoringSandbox.Instrumenters.Cats do
  use Prometheus.Metric

  def setup() do
    Counter.declare(
      name: :monitoring_sandbox_cats_total,
      help: "Cats Count"
    )
  end

  def increment do
    Counter.inc(name: :monitoring_sandbox_cats_total)
  end
end
