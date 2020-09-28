defmodule ImsReport.Test.ReportJobTest do
  use ExUnit.Case, async: false
  import Mock
  alias ImsReport.Job.ReportJob
  alias ImsReport.Generator.ReportGenerator

  @create_product_report_msg %{"type" => "product", "action" => "create"}

  describe "perform" do
    test_with_mock "calls ReportGenerator.create with the right type",
      ReportGenerator, [], [create: fn(_type) -> :ok end] do

      ReportJob.perform(@create_product_report_msg)

      assert_called(ReportGenerator.create(:product))
    end
  end
end
