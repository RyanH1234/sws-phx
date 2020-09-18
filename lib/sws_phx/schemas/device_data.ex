defmodule SwsPhx.Schemas.DeviceData do
  use Ecto.Schema
  import Ecto.Changeset

  alias SwsPhx.Schemas.Device
  alias SwsPhx.Schemas.DeviceDataType

  schema "device_datas" do
    belongs_to :device, Device
    belongs_to :device_data_type, DeviceDataType
    field :value, :string
    field :timestamp, :utc_datetime
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:device_id, :device_data_type_id, :value])
    |> validate_required([:device_id, :device_data_type_id, :value])
  end
end
