defmodule ImsReportWeb.PageController do
  use ImsReportWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
