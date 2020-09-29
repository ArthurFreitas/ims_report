defmodule ImsReport.Test.ReportParserTest do
  use ExUnit.Case

  alias ImsReport.Product
  alias ImsReport.Generator.ReportParser

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
  @parsed_dummy_data [
    [:SKU, :barcode, :description, :id, :name, :price, :quantity],
    ["SKU1", "00000001", "desc1", "id1", "teste1", 1, 1],
    ["SKU2", "00000002", "desc2", "id2", "teste2", 2, 2]
  ]

  @dummy_incomplete_data [
    %Product{
      SKU: "SKU1",
      name: "teste1",
      price: 1,
      quantity: 1
    }
  ]
  @parsed_dummy_incomplete_data [
    [:SKU, :barcode, :description, :id, :name, :price, :quantity],
    ["SKU1", "00000000", "-", "-", "teste1", 1, 1]
  ]


  describe "parse_structs_to_matrix" do
    test "parses complete data correctly" do
      assert ReportParser.parse_structs_to_matrix(@dummy_data) == @parsed_dummy_data
    end

    test "fills incomplete data with -" do
      assert ReportParser.parse_structs_to_matrix(@dummy_incomplete_data) == @parsed_dummy_incomplete_data
    end
  end
end
