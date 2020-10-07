defmodule ImsReport.Generator.ReportGenerator do
  alias ImsReport.ProductHelper
  alias ImsReport.Generator.ReportWriter
  alias ImsReport.Service.MailService

  @report_base_path "reports/"
  @csv_report_suffix "_report.csv"

  def create(:product) do
    case ProductHelper.list() do
      [] ->
        Sentry.capture_message("report_for_empty_list", extra: %{reason: "can't write a report for a empty product list"})
        {:error,"can't write a report for a empty product list"}
      list ->
        ReportWriter.write(list, path_for_report_type(:product))
    end

  end

  def create(:product, email) do
    case ProductHelper.list() do
      [] ->
        Sentry.capture_message("report_for_empty_list", extra: %{reason: "can't write a report for a empty product list"})
        {:error,"can't write a report for a empty product list"}
      list ->
        list
        |> ReportWriter.write(:as_string)
        |> MailService.sendReport(email)
    end
  end

  defp path_for_report_type(type), do: @report_base_path <> Atom.to_string(type) <> @csv_report_suffix
end
