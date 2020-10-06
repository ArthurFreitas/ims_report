defmodule ImsReport.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec
    children = [
      # Start the Telemetry supervisor
      ImsReportWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ImsReport.PubSub},
      # Start the Endpoint (http/https)
      ImsReportWeb.Endpoint,
      # Start a worker by calling: ImsReport.Worker.start_link(arg)
      # {ImsReport.Worker, arg}
      supervisor(ImsReport.Repo, [])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ImsReport.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ImsReportWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
