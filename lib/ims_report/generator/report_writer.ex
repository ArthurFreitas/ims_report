defmodule ImsReport.Generator.ReportWriter do
  alias ImsReport.Generator.ReportParser
  def write(struct_list, path) when is_bitstring(path) do
    case File.open(path, [:write, :utf8]) do
      {:ok, file} ->
        write(struct_list, :as_stream)
        |> Enum.each(&IO.write(file, &1))
        :ok

      {:error, _reason} = error -> error
    end
  end

  def write(struct_list, :as_string) do
    write(struct_list, :as_stream)
    |> Enum.join("")
  end

  def write(struct_list, :as_stream) do
    ReportParser.parse_structs_to_matrix(struct_list)
    |> CSV.encode()
  end
end
