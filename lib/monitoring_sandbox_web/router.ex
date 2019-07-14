defmodule MonitoringSandboxWeb.Router do
  use MonitoringSandboxWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1", MonitoringSandboxWeb do
    pipe_through :api

    post "/cats", CatController, :create
  end
end
