use Mix.Config

config :ims_report, ecto_repos: [ImsReport.Repo]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"