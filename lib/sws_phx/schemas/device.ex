defmodule SwsPhx.Schemas.Device do
  use Ecto.Schema
  import Ecto.Changeset

  alias SwsPhx.Schemas.User
  alias SwsPhx.Schemas.WateringSystem
  alias SwsPhx.Schemas.DeviceData

  schema "devices" do
    field :name, :string
    belongs_to :user, User
    has_many :watering_systems, WateringSystem
    has_many :device_datas, DeviceData
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:id, :name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
