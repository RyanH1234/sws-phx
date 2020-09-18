defmodule SwsPhx.Repo.Migrations.AddTimestampToDeviceData do
  use Ecto.Migration

  def change do
    alter table(:device_datas) do
      add :timestamp, :utc_datetime
    end
  end
end
