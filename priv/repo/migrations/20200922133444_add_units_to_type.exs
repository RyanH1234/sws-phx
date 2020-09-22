defmodule SwsPhx.Repo.Migrations.AddUnitsToType do
  use Ecto.Migration

  def change do
    alter table(:device_data_types) do
      add :unit, :string
    end
  end
end
