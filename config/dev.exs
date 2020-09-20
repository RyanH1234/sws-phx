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

config :logger, :console, format: "[$level] $message\n"
config :phoenix, :stacktrace_depth, 20
config :phoenix, :plug_init_mode, :runtime

if File.exists?("./config/dev.secret.exs") do
  import_config "dev.secret.exs"
end
