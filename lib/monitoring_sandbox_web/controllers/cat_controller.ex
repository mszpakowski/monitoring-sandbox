defmodule MonitoringSandboxWeb.CatController do
  use MonitoringSandboxWeb, :controller

  action_fallback(MonitoringSandboxWeb.FallbackController)

  alias MonitoringSandbox.Cats

  def create(conn, params) do
    with {:ok, cat} <- Cats.create(params) do
      conn
      |> put_status(:created)
      |> render("cat.json", %{cat: cat})
    end
  end
end
