defmodule ImsReport.Repo do
  use Ecto.Repo,
  otp_app: :ims_report,
  adapter: Mongo.Ecto
end
