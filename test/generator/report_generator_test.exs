defmodule ImsReport.Test.ReportGeneratorTest do
  use ExUnit.Case, async: false
  use ImsReport.DataCase, async: false
  import Mock
  alias ImsReport.Generator.{ReportWriter, ReportGenerator}
  alias ImsReport.{Product, ProductHelper}

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

  describe "create" do
    test_with_mock "calls report writer with queried data",
      ReportWriter, [], [write: fn(_list, _path) -> :ok end] do

      data = Enum.map(@product_dummy_data, fn(e) ->
        {ok, %Product{} = product} = ProductHelper.insert(e)
        Map.delete(product, :__meta__)
      end)

      ReportGenerator.create(:product)

      assert_called(ReportWriter.write(data,@product_report_path))
    end
  end
end
