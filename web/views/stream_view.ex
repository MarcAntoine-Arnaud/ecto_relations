defmodule EctoRelations.StreamView do
  use EctoRelations.Web, :view

  def render("index.json", %{streams: streams}) do
    %{data: render_many(streams, __MODULE__, "stream.json")}
  end

  def render("show.json", %{stream: stream}) do
    %{data: render_one(stream, __MODULE__, "stream.json")}
  end

  def render("stream.json", %{stream: stream}) do
    %{
      id: stream.id,
      index: stream.index,
      file_id: stream.file_id,
      inserted_at: stream.inserted_at,
      updated_at: stream.updated_at
    }
  end
end
