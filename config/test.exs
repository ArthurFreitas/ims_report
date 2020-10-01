use Mix.Config

config :ims_report, ImsReport.Repo,
  database: "ims_test",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 1

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ims_report, ImsReportWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
