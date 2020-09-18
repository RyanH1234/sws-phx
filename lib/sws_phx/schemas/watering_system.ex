defmodule SwsPhx.Schemas.WateringSystem do
  use Ecto.Schema
  import Ecto.Changeset

  alias SwsPhx.Schemas.Device

  schema "watering_systems" do
    field :timestamp, :utc_datetime
    field :relay_output, :integer
    belongs_to :device, Device
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :user_id, :device_id])
    |> validate_required([:name, :user_id, :device_id])
  end
end
