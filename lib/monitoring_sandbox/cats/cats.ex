defmodule MonitoringSandbox.Cats do
  alias MonitoringSandbox.{Cat, Repo}

  def create(%{"name" => "Azor"}) do
    raise ArgumentError, message: "That's not a cat's name!"
  end

  def create(params) do
    with {:ok, %Cat{}} = cat <- insert_cat(params) do
      cat
    end
  end

  defp insert_cat(params) do
    %Cat{}
    |> Cat.changeset(params)
    |> Repo.insert()
  end
end
