use Mix.Config

config :ims_report, ImsReport.Repo,
  database: "ims_development",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :task_bunny, hosts: [
  default: [connect_options: "amqp://localhost?heartbeat=30"]
]

config :task_bunny, queue: [
  namespace: "task_bunny.",
  queues: [[name: "report", jobs: [ImsReport.Job.ReportJob]]]
]
