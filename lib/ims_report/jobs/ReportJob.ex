defmodule ImsReport.Job.ReportJob do
  use TaskBunny.Job
  alias ImsReport.Generator.ReportGenerator

  def perform(%{"action" => action, "type" => type}) do
    method = String.to_atom(action)
    apply(ReportGenerator, method, [String.to_atom(type)])
    :ok
  end
end
