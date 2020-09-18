defmodule SwsPhx.Schemas.DeviceDataType do
  use Ecto.Schema
  import Ecto.Changeset


  schema "device_data_types" do
    field :description, :string
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:description])
    |> validate_required([:description])
  end
end
