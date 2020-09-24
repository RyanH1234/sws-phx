defmodule SwsPhx.Repo.Migrations.AddRelayOutputs do
  use Ecto.Migration

  def change do
    alter table(:watering_systems) do
      add :relay_output_1, :boolean
      add :relay_output_2, :boolean
      add :relay_output_3, :boolean
      add :relay_output_4, :boolean
      remove :relay_output
    end
  end
end
