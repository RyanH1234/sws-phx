use Mix.Config

config :sws_phx, SwsPhx.Repo,
  username: "postgres",
  password: "postgres",
  database: "sws_phx_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :sws_phx, SwsPhxWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

config :sws_phx, SwsPhx.Guardian,
  secret_key: "SpuuHArl+iPP97SpAMEfo+wMpIxMe+mGM84YqkIY9wwW8Ghx9mvxU+hHQqgKbVtH"

config :logger, :console, format: "[$level] $message\n"
config :phoenix, :stacktrace_depth, 20
config :phoenix, :plug_init_mode, :runtime
