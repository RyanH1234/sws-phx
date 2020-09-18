defmodule SwsPhx.Repo.Migrations.AddValueToDeviceData do
  use Ecto.Migration

  def change do
    alter table(:device_datas) do
      add :value, :string
    end
  end
end
