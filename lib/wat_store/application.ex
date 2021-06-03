defmodule WatStore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      WatStore.Repo,
      # Start the Telemetry supervisor
      WatStoreWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: WatStore.PubSub},
      # Start the Endpoint (http/https)
      WatStoreWeb.Endpoint,
      {Absinthe.Subscription, WatStoreWeb.Endpoint}
      # Start a worker by calling: WatStore.Worker.start_link(arg)
      # {WatStore.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WatStore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    WatStoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
