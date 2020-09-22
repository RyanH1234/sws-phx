defmodule SwsPhxWeb.DeviceController do
  use SwsPhxWeb, :controller
  import Ecto.Query, only: [from: 2]

  alias SwsPhx.Repo
  alias SwsPhx.Schemas.DeviceData
  alias SwsPhx.Schemas.DeviceDataType

  defp get_type_id(description) do
    from ddt in DeviceDataType,
      where: ddt.description == ^description,
      select: %{
        id: ddt.id
      }
  end

  def insert_device_data(conn, %{
        "token" => token,
        "timestamp" => timestamp,
        "type" => type_description,
        "value" => value,
        "device_id" => did
      }) do
    secret_key = Application.get_env(:sws_phx, SwsPhx.Guardian)[:secret_key]

    case secret_key == token do
      true ->
        # look up database to get device_data_type id
        %{id: type_id} = get_type_id(type_description) |> Repo.one()

        # create payload
        params = %{
          device_data_type_id: type_id,
          value: value,
          device_id: did,
          timestamp: timestamp
        }

        # insert into database
        device_data_changeset = DeviceData.changeset(%DeviceData{}, params)
        Repo.insert!(device_data_changeset)
        json(conn, "success")

      false ->
        json(conn, "error")
    end
  end
end
