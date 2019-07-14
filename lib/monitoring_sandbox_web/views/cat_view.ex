defmodule MonitoringSandboxWeb.CatView do
  use MonitoringSandboxWeb, :view

  def render("cat.json", %{cat: cat}) do
    %{
      name: cat.name,
      race: cat.race
    }
  end
end
