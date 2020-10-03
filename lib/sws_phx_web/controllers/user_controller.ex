defmodule SwsPhxWeb.UserController do
  use SwsPhxWeb, :controller
  import Ecto.Query, only: [from: 2]

  alias SwsPhx.Auth
  alias SwsPhx.Repo
  alias SwsPhx.Schemas.User
  alias SwsPhx.Schemas.Device
  alias SwsPhx.Schemas.DeviceData
  alias SwsPhx.Schemas.DeviceDataType

  def login(conn, %{"params" => %{"email" => email, "password" => password}}) do
    auth = Auth.login_by_email_and_pwd(conn, email, password, repo: Repo)

    case auth do
      {:ok, conn, {user, token}} ->
        user = %{
          id: user.id,
          email: user.email,
          token: token
        }

        json(conn, user)

      {:error, _reason, conn} ->
        send_resp(conn, 401, "unauthorised access")
    end
  end

  def create_user(conn, %{"client" => client_params}) do
    client_changeset = User.registration_changeset(%User{}, client_params)
    Repo.insert!(client_changeset)
    json(conn, "success")
  end

  def add_device(conn, params) do
    device_changeset = Device.changeset(%Device{}, params)
    Repo.insert!(device_changeset)
    json(conn, "success")
  end

  def delete_device(conn, %{"did" => did}) do
    did = String.to_integer(did)
    device_changeset = %Device{id: did}
    Repo.delete(device_changeset)
    json(conn, "success")
  end

  # localhost:4000/user/device/all?uid=8
  def get_all_devices(conn, %{"uid" => uid}) do
    resp =
      Repo.get(User, uid)
      |> Repo.preload(:devices)

    devices =
      Enum.map(resp.devices, fn device ->
        %{
          id: device.id,
          name: device.name
        }
      end)

    json(conn, devices)
  end

  defp get_device_data_ts(did, start_utc, end_utc) do
    from dd in DeviceData,
      where: dd.device_id == ^did,
      join: ddt in DeviceDataType,
      on: ddt.id == dd.device_data_type_id,
      where: dd.timestamp > ^start_utc,
      where: dd.timestamp < ^end_utc,
      select: %{
        type: ddt.description,
        type_id: ddt.id,
        value: dd.value,
        device_id: dd.device_id,
        timestamp: dd.timestamp,
        unit: ddt.unit
      }
  end

  def get_device_data(conn, %{"did" => did, "start" => start_utc, "end" => end_utc}) do
    ts_data =
      get_device_data_ts(did, start_utc, end_utc)
      |> Repo.all()
      |> Enum.map(fn data ->
        case data.unit do
          nil ->
            data

          _ ->
            type = (data.type <> " " <> data.unit)
            %{data | type: type}
        end
      end)
      |> Enum.group_by(& &1.type)
      |> Enum.reduce(%{}, fn {attr, data}, acc ->
        sorted = Enum.sort(data, &(DateTime.compare(&1.timestamp, &2.timestamp) != :gt))
        Map.put(acc, attr, sorted)
      end)

    json(conn, ts_data)
  end

  defp get_all_device_data(did) do
    from dd in DeviceData,
      where: dd.device_id == ^did,
      join: ddt in DeviceDataType,
      on: ddt.id == dd.device_data_type_id,
      order_by: [desc: dd.timestamp],
      select: %{
        type: ddt.description,
        type_id: ddt.id,
        value: dd.value,
        device_id: dd.device_id,
        timestamp: dd.timestamp,
        unit: ddt.unit
      }
  end

  def get_dash_data(conn, %{"uid" => uid}) do
    user =
      Repo.get(User, uid)
      |> Repo.preload(:devices)

    device_ids = Enum.map(user.devices, & &1.id)

    dash_data =
      Enum.map(device_ids, fn did ->
        device_data =
          get_all_device_data(did)
          |> Repo.all()
          |> Enum.group_by(& &1.type)
          |> Enum.map(fn {_type, [latest_value | _tail]} ->
            %{
              latest_value: latest_value
            }
          end)

        %{
          device_id: did,
          device_data: device_data
        }
      end)

    json(conn, dash_data)
  end

  def options(conn, _params), do: json(conn, :ok)
end
