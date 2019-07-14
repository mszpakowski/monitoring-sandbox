defmodule MonitoringSandboxWeb.FallbackController do
  use Phoenix.Controller

  def call(conn, {:error, %Ecto.Changeset{}}) do
    conn
    |> put_status(:bad_request)
    |> put_view(MonitoringSandboxWeb.ErrorView)
    |> render("400.json")
  end
end
