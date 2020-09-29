defmodule ImsReport.Generator.ReportGenerator do
  alias ImsReport.ProductHelper
  alias ImsReport.Generator.ReportWriter

  @product_report_path "product_report.csv"

  def create(type) do
    case type do
    :product ->
      ProductHelper.list()
      |> clean_struct_list()
      |> ReportWriter.write(@product_report_path)
    end
  end

  defp clean_struct_list(list) do
    list
    |> Enum.map(&clean_struct/1)
  end

  defp clean_struct(struct), do: Map.delete(struct,:__meta__)
end
