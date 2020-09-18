defmodule SwsPhx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SwsPhx.Repo,
      # Start the Telemetry supervisor
      SwsPhxWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SwsPhx.PubSub},
      # Start the Endpoint (http/https)
      SwsPhxWeb.Endpoint
      # Start a worker by calling: SwsPhx.Worker.start_link(arg)
      # {SwsPhx.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SwsPhx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SwsPhxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
