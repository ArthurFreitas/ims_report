defmodule ImsReport.Generator.ReportParser do

  @default_missing_data_value "-"

  def parse_structs_to_matrix(struct_list) do
    headers = get_headers(struct_list)

    data_lists = struct_list
    |> Enum.map(&parse_struct_to_list(&1,headers))

    [headers | data_lists]
  end

  defp get_headers([%{__meta__: _meta, __struct__: _struct} = head| _tail]) do
    head
    |> Map.drop([:__meta__, :__struct__])
    |> Map.keys()
  end

  defp parse_struct_to_list(struct_list, headers) do
    headers
    |> Enum.map(
      fn(k) ->
        Map.get(struct_list, k) || @default_missing_data_value
      end
    )
  end
end
