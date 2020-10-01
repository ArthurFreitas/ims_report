defmodule ImsReport.Job.ReportJob do
  use TaskBunny.Job
  alias ImsReport.Generator.ReportGenerator

  def perform(%{"action" => action, "type" => type, "email" => email}) do
    action
    |> call_report_generator([
      String.to_atom(type),
      email
    ])
    :ok
  end
  def perform(%{"action" => action, "type" => type}) do
    action
    |> call_report_generator([
      String.to_atom(type)
    ])
    :ok
  end

  defp call_report_generator(action, args) do
    method = String.to_atom(action)
    apply(ReportGenerator, method, args)
  end
end
