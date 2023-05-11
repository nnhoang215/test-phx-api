defmodule TestPhxApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TestPhxApiWeb.Telemetry,
      # Start the Ecto repository
      TestPhxApi.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: TestPhxApi.PubSub},
      # Start the Endpoint (http/https)
      TestPhxApiWeb.Endpoint
      # Start a worker by calling: TestPhxApi.Worker.start_link(arg)
      # {TestPhxApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TestPhxApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TestPhxApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
