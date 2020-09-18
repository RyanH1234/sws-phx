defmodule SwsPhx.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias SwsPhx.Schemas.Device

  alias Comeonin.Bcrypt

  schema "users" do
    field :email, :string
    field :password, :string
    has_many :devices, Device
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
  end


  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password, Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end

  def registration_changeset(user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password])
    |> put_pass_hash()
  end
end
