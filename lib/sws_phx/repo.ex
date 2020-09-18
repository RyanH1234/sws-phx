defmodule SwsPhx.Repo do
  use Ecto.Repo,
    otp_app: :sws_phx,
    adapter: Ecto.Adapters.Postgres
end
