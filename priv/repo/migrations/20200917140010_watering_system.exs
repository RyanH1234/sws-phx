defmodule SwsPhx.Repo.Migrations.WateringSystem do
  use Ecto.Migration

  def change do
    create table(:watering_systems) do
      add :device_id, references(:devices)
      add :timestamp, :utc_datetime
      add :relay_output, :integer
    end
  end
end
