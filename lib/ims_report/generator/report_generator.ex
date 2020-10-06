defmodule ImsReport.Generator.ReportGenerator do
  alias ImsReport.ProductHelper
  alias ImsReport.Generator.ReportWriter
  alias ImsReport.Service.MailService

  @report_base_path "reports/"
  @csv_report_suffix "_report.csv"

  def create(type) do
    case type do
    :product ->
      ReportWriter.write(ProductHelper.list(), path_for_report_type(type))
    end
  end

  def create(type, email) do
    case type do
      :product ->
        ProductHelper.list()
        |> ReportWriter.write(:as_string)
        |> MailService.sendReport(email)
    end
  end

  defp path_for_report_type(type), do: @report_base_path <> Atom.to_string(type) <> @csv_report_suffix
end
