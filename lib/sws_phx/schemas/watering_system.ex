defmodule SwsPhx.Schemas.WateringSystem do
  use Ecto.Schema
  import Ecto.Changeset

  alias SwsPhx.Schemas.Device

  schema "watering_systems" do
    field :timestamp, :utc_datetime
    field :relay_output_1, :boolean
    field :relay_output_2, :boolean
    field :relay_output_3, :boolean
    field :relay_output_4, :boolean

    belongs_to :device, Device
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:device_id, :timestamp, :relay_output_1, :relay_output_2, :relay_output_3, :relay_output_4])
    |> validate_required([:device_id, :timestamp, :relay_output_1, :relay_output_2, :relay_output_3, :relay_output_4])
  end
end
