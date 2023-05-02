defmodule LiveviewNavigationDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LiveviewNavigationDemoWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveviewNavigationDemo.PubSub},
      # Start Finch
      {Finch, name: LiveviewNavigationDemo.Finch},
      # Start the Endpoint (http/https)
      LiveviewNavigationDemoWeb.Endpoint
      # Start a worker by calling: LiveviewNavigationDemo.Worker.start_link(arg)
      # {LiveviewNavigationDemo.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveviewNavigationDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveviewNavigationDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
