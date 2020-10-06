defmodule ImsReport.Test.ReportGeneratorTest do
  use ExUnit.Case, async: false
  use ImsReport.DataCase, async: false
  import Mock
  alias ImsReport.Generator.{ReportWriter, ReportGenerator}
  alias ImsReport.{Product, ProductHelper}
  alias ImsReport.Service.MailService

  @product_dummy_data [
    %{
      SKU: "testeSKU1",
      description: "testeSKU1",
      name: "teste1",
      quantity: 50
    },
    %{
      SKU: "testeSKU2",
      description: "testeSKU2",
      name: "teste2",
      quantity: 50
    }
  ]
  @product_report_path "reports/product_report.csv"
  @to_email "teste@skyhub.com"

  describe "create" do
    test_with_mock "calls report writer with queried data",
      ReportWriter, [], [write: fn(_list, _path) -> :ok end] do
      data = insert_dummy_data_into_db()
      ReportGenerator.create(:product)

      assert_called(ReportWriter.write(data,@product_report_path))
    end

    test "calls mail service send report with the given email and report" do
      with_mocks([
        {ReportWriter, [], [write: fn(_list, :as_string) -> "csv_string" end]},
        {MailService, [], [sendReport: fn("csv_string", @to_email) -> :ok end]}
      ]) do
        data = insert_dummy_data_into_db()
        ReportGenerator.create(:product, @to_email)

        assert_called(ReportWriter.write(data, :as_string))
        assert_called(MailService.sendReport("csv_string", @to_email))
      end
    end
  end

  defp insert_dummy_data_into_db do
    Enum.map(@product_dummy_data, fn(e) ->
      {_ok, %Product{} = product} = ProductHelper.insert(e)
      Map.delete(product, :__meta__)
    end)
  end
end
