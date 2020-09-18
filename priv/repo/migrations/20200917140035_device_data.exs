defmodule SwsPhx.Repo.Migrations.DeviceData do
  use Ecto.Migration

  def change do
    create table(:device_datas) do
      add :device_id, references(:devices)
      add :device_data_type_id, references(:device_data_types)
    end
  end
end
