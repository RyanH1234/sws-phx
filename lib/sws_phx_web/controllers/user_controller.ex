defmodule SwsPhxWeb.UserController do
  use SwsPhxWeb, :controller

  alias SwsPhx.Auth
  alias SwsPhx.Repo
  alias SwsPhx.Schemas.User
  alias SwsPhx.Schemas.Device

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

  # localhost:4000/user/device/all?uid=8
  def get_all_devices(conn, %{"uid" => uid}) do
    resp =
      Repo.get(User, uid)
      |> Repo.preload(:devices)

    devices = Enum.map(resp.devices, fn device ->
      %{
        id: device.id,
        name: device.name,
      }
    end)

    json(conn, devices)
  end

  def options(conn, _params), do: json(conn, :ok)
end
