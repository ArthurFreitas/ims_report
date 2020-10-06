defmodule ImsReportWeb.ReportController do
  use ImsReportWeb, :controller

  def create(conn, params) do
    params
    |> Map.put("action", "create")
    |> ImsReport.Job.ReportJob.enqueue()

    json(conn, "")
  end
end
