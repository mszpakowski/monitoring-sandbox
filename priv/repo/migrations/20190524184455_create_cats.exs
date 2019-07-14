defmodule MonitoringSandbox.Repo.Migrations.CreateCats do
  use Ecto.Migration

  def change do
    create table(:cats) do
      add(:name, :string)
      add(:race, :string)

      timestamps(type: :naive_datetime_usec)
    end
  end
end
