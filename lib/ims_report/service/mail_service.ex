defmodule ImsReport.Service.MailService do
  use Tesla

  plug Tesla.Middleware.BaseUrl, Application.get_env(:ims, :mail_service_api_url)
  plug Tesla.Middleware.JSON

  def sendReport(report, email) do
    body = %{email: email, report: report}
    post("/send", body)
  end
end
