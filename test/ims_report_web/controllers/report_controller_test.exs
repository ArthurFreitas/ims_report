defmodule ImsReport.ReportControllerTest do
  use ExUnit.Case, async: false
  use ImsReportWeb.ConnCase
  alias ImsReport.Job.ReportJob
  import Mock

  @to_email "test@skyhub.com"

  @report_to_file_received_params %{"type" => :product}
  @report_to_file_job_args Map.put @report_to_file_received_params, "action", "create"

  @report_to_email_received_params %{"type" => :product, "email" => @to_email}
  @report_to_email_job_args Map.put @report_to_email_received_params, "action", "create"



  describe "create" do
    test_with_mock "returns ok and enqueues report to file job", %{conn: conn},
      ReportJob, [], [enqueue: fn(_args) -> :ok end] do

      conn = post(conn, Routes.report_path(conn, :create), @report_to_file_received_params)

      assert conn.status == 200
      assert_called(ReportJob.enqueue(@report_to_file_job_args))
    end

    test_with_mock "returns ok and enqueues report to email job", %{conn: conn},
      ReportJob, [], [enqueue: fn(_args) -> :ok end] do

      conn = post(conn, Routes.report_path(conn, :create), @report_to_email_received_params)

      assert conn.status == 200
      assert_called(ReportJob.enqueue(@report_to_email_job_args))
    end
  end
end
