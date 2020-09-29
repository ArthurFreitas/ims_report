defmodule ImsReport.Generator.ReportGenerator do
  alias ImsReport.ProductHelper
  alias ImsReport.Generator.ReportWriter

  @product_report_path "product_report.csv"

  def create(type) do
    case type do
    :product ->
      ProductHelper.list()
      |> ReportWriter.write(@product_report_path)
    end
  end
end
