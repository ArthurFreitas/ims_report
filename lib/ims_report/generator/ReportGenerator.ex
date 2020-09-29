defmodule ImsReport.Generator.ReportGenerator do
  alias ImsReport.ProductHelper
  alias ImsReport.Generator.ReportWriter

  @report_base_path "reports/"
  @csv_report_suffix "_report.csv"

  def create(type) do
    case type do
    :product ->
      ProductHelper.list()
      |> ReportWriter.write(path_for_report_type(type))
    end
  end

  defp path_for_report_type(type), do: @report_base_path <> Atom.to_string(type) <> @csv_report_suffix
end
