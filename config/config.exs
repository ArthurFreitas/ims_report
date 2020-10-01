# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ims_report, ecto_repos: [ImsReport.Repo]

# Configures the endpoint
config :ims_report, ImsReportWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oIWUy5FYnEx5xXiBYRh0oS15oDX0Qti3MP8EDuaYvUvBxFC6xktlbqxTkRyrtoe8",
  render_errors: [view: ImsReportWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ImsReport.PubSub,
  live_view: [signing_salt: "bzbt8T2R"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :ims, :mail_service_url, "localhost:4002"
