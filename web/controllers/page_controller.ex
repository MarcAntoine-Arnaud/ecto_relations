defmodule EctoRelations.PageController do
  use EctoRelations.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
