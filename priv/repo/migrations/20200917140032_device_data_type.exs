defmodule SwsPhx.Repo.Migrations.DeviceDataType do
  use Ecto.Migration

  def change do
    create table(:device_data_types) do
      add :description, :string
    end
  end
end
