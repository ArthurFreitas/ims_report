defmodule ImsReportWeb.PageController do
  use ImsReportWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end


  def sentry_check(_conn, _params) do
    raise "Hello from report service"
  end
end
