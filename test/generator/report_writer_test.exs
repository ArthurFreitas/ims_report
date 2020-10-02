defmodule ImsReport.Test.ReportWriterTest do
  use ExUnit.Case, async: false
  import Mock
  alias ImsReport.Generator.ReportWriter
  alias ImsReport.Product

  @dummy_data [
    %Product{
      id: "id1",
      SKU: "SKU1",
      description: "desc1",
      name: "teste1",
      barcode: "00000001",
      price: 1,
      quantity: 1
    },
    %Product{
      id: "id2",
      SKU: "SKU2",
      description: "desc2",
      name: "teste2",
      barcode: "00000002",
      price: 2,
      quantity: 2
    }
  ]

  setup_with_mocks([
    {File, [], [open: fn
      ("valid_path", _opts) -> {:ok, :io_device}
      ("non_valid_path", _opts) -> {:error, :reason}
    end]},
    {IO, [:passthrough], [write: fn(io_device, data) -> :ok end]}
  ]) do
    :ok
  end

  describe "write" do
    test "a report to a valid path" do
      status = ReportWriter.write(@dummy_data, "valid_path")

      assert_called(File.open("valid_path", [:write, :utf8]))
      assert_called(IO.write(:io_device, "SKU,barcode,description,id,name,price,quantity\r\n"))
      assert_called(IO.write(:io_device, "SKU1,00000001,desc1,id1,teste1,1,1\r\n"))
      assert_called(IO.write(:io_device, "SKU2,00000002,desc2,id2,teste2,2,2\r\n"))
      assert status == :ok
    end

    test "a report to a not valid path" do
      status = ReportWriter.write(@dummy_data, "non_valid_path")

      assert_called(File.open("non_valid_path", [:write, :utf8]))
      assert {:error, _} = status
    end

    test "returns a valid csv String" do
      csv = ReportWriter.write(@dummy_data, :as_string)

      assert csv = "SKU,barcode,description,id,name,price,quantity\r\nSKU1,00000001,desc1,id1,teste1,1,1\r\nSKU2,00000002,desc2,id2,teste2,2,2\r\n"
    end
  end
end
