defmodule ImsReport.Test.ReportJobTest do
  use ExUnit.Case, async: false
  import Mock
  alias ImsReport.Job.ReportJob
  alias ImsReport.Generator.ReportGenerator

  @to_email "teste@skyhub.com"
  @create_product_report_msg %{"type" => "product", "action" => "create"}
  @send_product_report_email_msg %{"type" => "product", "action" => "create", "email" => @to_email}

  describe "perform" do
    test_with_mock "calls ReportGenerator create with the right type",
      ReportGenerator, [], [create: fn(_type) -> :ok end] do

      ReportJob.perform(@create_product_report_msg)

      assert_called(ReportGenerator.create(:product))
    end

    test_with_mock "calls ReportGenerator create with the right type and email",
      ReportGenerator, [], [create: fn(_type, _email) -> :ok end] do

      ReportJob.perform(@send_product_report_email_msg)

      assert_called(ReportGenerator.create(:product, @to_email))
    end
  end
end
