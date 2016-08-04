defmodule EctoRelations.FileView do
  use EctoRelations.Web, :view

  def render("index.json", %{files: files}) do
    %{data: render_many(files, __MODULE__, "file.json")}
  end

  def render("show.json", %{file: file}) do
    %{data: render_one(file, __MODULE__, "file.json")}
  end

  def render("file.json", %{file: file}) do
    %{
      id: file.id,
      path: file.path,
      inserted_at: file.inserted_at,
      updated_at: file.updated_at
    }
  end
end
