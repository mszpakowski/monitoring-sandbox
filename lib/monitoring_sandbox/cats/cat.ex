defmodule MonitoringSandbox.Cat do
  use Ecto.Schema

  schema "cats" do
    field(:name, :string)
    field(:race, :string)

    timestamps()
  end

  @required_params [:name, :race]

  def changeset(cat, params \\ %{}) do
    cat
    |> Ecto.Changeset.cast(params, @required_params)
    |> Ecto.Changeset.validate_required(@required_params)
  end
end
