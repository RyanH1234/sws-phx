defmodule SwsPhx.Auth do
  import Plug.Conn

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias SwsPhx.Guardian
  alias SwsPhx.Schemas.User

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def get_token(conn, []), do: send_resp(conn, 401, "unauthorised access")

  def get_token(_conn, header) do
    [_, token] =
      List.first(header)
      |> String.split()

    token
  end

  def check_if_verified(conn, {:ok, %{"sub" => id}}, repo) do
    user = repo.get(User, id)

    conn
    |> assign(:user_id, id)
    |> assign(:current_user, user)
  end

  def check_if_verified(conn, _, _), do: send_resp(conn, 401, "unauthorised access")

  def call(conn, repo) do
    header = get_req_header(conn, "authorization")
    token = get_token(conn, header)
    verified = Guardian.decode_and_verify(token)
    check_if_verified(conn, verified, repo)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> fetch_session()
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    conn
    |> fetch_session()
    |> configure_session(drop: true)
  end

  def login_by_email_and_pwd(conn, email, given_pwd, opts) do
    repo = Keyword.fetch!(opts, :repo)

    user = repo.get_by(User, email: email)

    cond do
      user && checkpw(given_pwd, user.password) ->
        {_, token, _} = Guardian.encode_and_sign(user)
        conn = login(conn, user)
        {:ok, conn, {user, token}}

      user ->
        {:error, :unauthorised, conn}

      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end
end
