defmodule EctoRelations.EssenceView do
  use EctoRelations.Web, :view

  require Logger

  def render("index.json", %{essences: essences}) do
    %{data: render_many(essences, __MODULE__, "essence.json")}
  end

  def render("show.json", %{essence: essence}) do
    %{data: render_one(essence, __MODULE__, "essence.json")}
  end

  def render("new.json", conn) do
    Logger.error conn.changeset.errors
    %{errors: "unknown"}
  end

  def render("essence.json", %{essence: essence}) do
    Logger.info "#{inspect essence}"
    Logger.info "#{inspect essence.streams}"
    streams = render_many(essence.streams, EctoRelations.StreamView, "stream.json")
    %{
      id: essence.id,
      kind: essence.kind,
      codec: essence.codec,
      streams: streams,
      inserted_at: essence.inserted_at,
      updated_at: essence.updated_at
    }
  end
end
