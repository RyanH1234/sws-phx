use Mix.Config

config :sws_phx,
  ecto_repos: [SwsPhx.Repo]

config :sws_phx, SwsPhxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "g27LpzKvXV+o0KLUKuzwZXYgvGDcpwLGMB4FPs5JGgPWHprUE8/mCV/NI72O1ci+",
  render_errors: [view: SwsPhxWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SwsPhx.PubSub,
  live_view: [signing_salt: "c6uZkfFG"]

config :sws_phx, SwsPhx.Guardian,
  issuer: "SwsPhx"

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
