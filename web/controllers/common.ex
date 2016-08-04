defmodule EctoRelations.Common do
  def template(conn, base) do
    case conn.path_info |> List.first do
      "api" -> base <> ".json"
      _ -> base <> ".html"
    end
  end
end
