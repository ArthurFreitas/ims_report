defmodule ImsReport.Generator.ReportWriter do
  alias ImsReport.Generator.ReportParser
  def write(struct_list, path) do
    case File.open(path, [:write, :utf8]) do
      {:ok, file} ->
        ReportParser.parse_structs_to_matrix(struct_list)
        |> CSV.encode()
        |> Enum.each(&IO.write(file, &1))
        :ok

      {:error, _reason} = error -> error
    end
  end
end
