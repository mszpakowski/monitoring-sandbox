defmodule MonitoringSandboxWeb.RequestSimulator do
  use GenServer

  @headers [{"content-type", "application/json"}, {"accept", "application/json"}]

  def start_link(interval) do
    GenServer.start_link(__MODULE__, interval, name: __MODULE__)
  end

  def init(interval) do
    {:ok, interval, {:continue, :schedule_requests}}
  end

  def handle_continue(:schedule_requests, interval) do
    Process.send_after(self(), :make_requests, interval)
    {:noreply, interval}
  end

  def handle_info(:make_requests, interval) do
    number_of_requests = Enum.random(100..200)

    Stream.each(1..number_of_requests, fn _ ->
      {:ok, conn} = Mint.HTTP.connect(protocol(), host(), port())

      {:ok, conn, _request_ref} = randomize_request(conn)

      receive do
        message -> Mint.HTTP.stream(conn, message)
      end

      {:ok, _conn} = Mint.HTTP.close(conn)
    end)
    |> Stream.run()

    {:noreply, interval, {:continue, :schedule_requests}}
  end

  defp randomize_request(conn) do
    Enum.random(1..10)
    |> case do
      number when number == 10 ->
        Mint.HTTP.request(
          conn,
          "POST",
          "/v1/cats",
          @headers,
          Poison.encode!(%{name: "Azor", race: "German shepherd"})
        )

      number when number >= 8 ->
        Mint.HTTP.request(conn, "GET", "/", [])

      number when number >= 5 ->
        Mint.HTTP.request(conn, "POST", "/v1/cats", @headers, "{}")

      _ ->
        Mint.HTTP.request(conn, "POST", "/v1/cats", @headers, randomize_body())
    end
  end

  defp randomize_body do
    Poison.encode!(%{
      name: :crypto.strong_rand_bytes(3) |> Base.encode64(),
      race: :crypto.strong_rand_bytes(3) |> Base.encode64()
    })
  end

  defp protocol, do: Confex.fetch_env!(:monitoring_sandbox, :protocol)
  defp host, do: Confex.fetch_env!(:monitoring_sandbox, :host)
  defp port, do: Confex.fetch_env!(:monitoring_sandbox, :port)
end
